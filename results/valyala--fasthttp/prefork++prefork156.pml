#define prefork_goMaxProcs  3

// https://github.com/valyala/fasthttp/blob/70e00dc4f3b8c1ac01a2e82410c9f4d59248c099/prefork/prefork.go#L156
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef sigCh;
	int num_msgs = 0;
	bool state = false;
	int i;
	int goMaxProcs = prefork_goMaxProcs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: goMaxProcs > 0 -> 
		sigCh.size = goMaxProcs;
		run AsyncChan(sigCh)
	:: else -> 
		run sync_monitor(sigCh)
	fi;
		for(i : 0.. goMaxProcs-1) {
		for20: skip;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run go_Anonymous0(sigCh);
		for20_end: skip
	};
	for20_exit: skip;
	do
	:: true -> 
		

		if
		:: sigCh.async_rcv?state,num_msgs;
		:: sigCh.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for30: skip;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			run go_Anonymous1(sigCh);
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef sigCh) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: sigCh.async_send!0;
	:: sigCh.sync!false,0 -> 
		sigCh.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef sigCh) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: sigCh.async_send!0;
	:: sigCh.sync!false,0 -> 
		sigCh.sending?state
	fi;
	stop_process: skip
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;  // sending channel is open
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

