
// https://github.com/gocircuit/circuit/blob/fd2add79ac1e5c203803f3e845169584c2aafaa5/kit/pubsub/pubsub.go#L145
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
	Chandef ch2;
	Chandef ch1;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 1 > 0 -> 
		ch1.size = 1;
		run AsyncChan(ch1)
	:: else -> 
		run sync_monitor(ch1)
	fi;
	

	if
	:: 1 > 0 -> 
		ch2.size = 1;
		run AsyncChan(ch2)
	:: else -> 
		run sync_monitor(ch2)
	fi;
	run go_loop(ch1,ch2);
	goto stop_process
stop_process:skip
}

proctype go_loop(Chandef ch1;Chandef ch2) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	__preclose: skip;
		do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			do
			:: ch1.async_rcv?state,num_msgs -> 
				

				if
				:: true -> 
					goto __preclose
				:: true;
				fi;
				break
			:: ch1.sync?state,num_msgs -> 
				

				if
				:: true -> 
					goto __preclose
				:: true;
				fi;
				break
			:: ch2.async_send!0 -> 
				break
			:: ch2.sync!false,0 -> 
				ch2.sending?state;
				break
			od
		:: true -> 
			

			if
			:: ch1.async_rcv?state,num_msgs;
			:: ch1.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto __preclose
			:: true;
			fi
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	do
	:: true -> 
		for20: skip;
		

		if
		:: true -> 
			ch2.closing!true;
			goto stop_process
		:: true;
		fi;
		

		if
		:: ch2.async_send!0;
		:: ch2.sync!false,0 -> 
			ch2.sending?state
		fi;
		for20_end: skip
	od;
	for20_exit: skip;
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

