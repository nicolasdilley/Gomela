
// https://github.com/istio/istio/blob/master/galley/pkg/config/processing/snapshotter/strategy/debounce_test.go#L210
typedef Chandef {
	chan sync = [0] of {bool};
	chan enq = [0] of {int};
	chan deq = [0] of {bool,int};
	chan sending = [0] of {bool};
	chan rcving = [0] of {bool};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	chan child_TestDrainTimeCh_Empty2100 = [1] of {int};
	run TestDrainTimeCh_Empty210(child_TestDrainTimeCh_Empty2100)
stop_process:skip
}

proctype TestDrainTimeCh_Empty210(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_drainTimeCh1780 = [1] of {int};
	Chandef ch;
	

	if
	:: 1 > 0 -> 
		ch.size = 1;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run drainTimeCh178(ch,child_drainTimeCh1780);
	child_drainTimeCh1780?0;
	stop_process: skip;
	child!0
}
proctype drainTimeCh178(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		do
		:: ch.deq?state,num_msgs -> 
			

			if
			:: true -> 
				goto loop
			:: true;
			fi;
			break
		:: ch.sync?state -> 
			ch.rcving!false;
			

			if
			:: true -> 
				goto loop
			:: true;
			fi;
			break
		:: true -> 
			goto loop;
			break
		od;
		for10_end: skip
	od;
	for10_exit: skip;
	loop: skip;
	stop_process: skip;
	child!0
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.rcving?false;
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.sync!true -> 
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.deq!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		    ch.closed = true
		   :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.enq?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.rcving?false ->
 		    ch.sending?false;
		fi;
		:: else -> 
		end3: if
		  :: ch.enq?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.deq!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		     ch.closed = true
		  :: ch.rcving?false ->
 		    ch.sending?false;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.rcving?false;
  :: ch.sync!true; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.rcving?false ->
       ch.sending?false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

