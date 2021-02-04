#define setupResolvers_addrs  3

// https://github.com/caffix/amass/blob/5a51b3330ef22606ad6b6a58df697a36b20d56c8/systems/local.go#L286
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
	Chandef finished;
	int num_msgs = 0;
	bool state = false;
	int i;
	int l=0;
	int addrs = setupResolvers_addrs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 10 > 0 -> 
		finished.size = 10;
		run AsyncChan(finished)
	:: else -> 
		run sync_monitor(finished)
	fi;
		for(i : 0.. addrs-1) {
		for10: skip;
		run go_Anonymous0(finished);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && l-1 != -3 -> 
				for(i : 0.. l-1) {
			for2011: skip;
			

			if
			:: finished.async_rcv?state,num_msgs;
			:: finished.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto for20_end11
				:: true;
				fi
			:: true;
			fi;
			for20_end11: skip
		};
		for20_exit11: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: finished.async_rcv?state,num_msgs;
			:: finished.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto for20_end
				:: true;
				fi
			:: true;
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef ch) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: ch.async_send!0;
			:: ch.sync!false,0 -> 
				ch.sending?state
			fi;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: ch.async_send!0;
	:: ch.sync!false,0 -> 
		ch.sending?state
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


