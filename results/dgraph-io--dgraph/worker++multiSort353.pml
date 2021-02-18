#define multiSort_ts_Order  0

// https://github.com/dgraph-io/dgraph/blob/ee0b99586ab740fbdec6da78605624c7feba2e5d/worker/sort.go#L353
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
	Chandef och;
	int num_msgs = 0;
	bool state = false;
	int i;
	int ts_Order = multiSort_ts_Order;
	

	if
	:: ts_Order - 1 > 0 -> 
		och.size = ts_Order - 1;
		run AsyncChan(och)
	:: else -> 
		run sync_monitor(och)
	fi;
		for(i : 1.. ts_Order-1) {
		for30: skip;
		run go_fetchValues(och);
		for30_end: skip
	};
	for30_exit: skip;
	

	if
	:: 1 != -2 && ts_Order-1 != -3 -> 
				for(i : 1.. ts_Order-1) {
			for40606: skip;
			

			if
			:: och.async_rcv?state,num_msgs;
			:: och.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto for40_end606
			:: true;
			fi;
			for40_end606: skip
		};
		for40_exit606: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			

			if
			:: och.async_rcv?state,num_msgs;
			:: och.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto for40_end
			:: true;
			fi;
			for40_end: skip
		:: true -> 
			break
		od;
		for40_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_fetchValues(Chandef or) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: or.async_send!0;
	:: or.sync!false,0 -> 
		or.sending?state
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

