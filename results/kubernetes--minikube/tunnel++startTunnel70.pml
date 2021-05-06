
// https://github.com/kubernetes/minikube/blob/master/pkg/minikube/tunnel/tunnel_manager.go#L70
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
	chan child_startTunnel700 = [1] of {int};
	run startTunnel70(child_startTunnel700)
stop_process:skip
}

proctype startTunnel70(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_run951 = [1] of {int};
	chan child_timerLoop850 = [1] of {int};
	Chandef done;
	Chandef check;
	Chandef ready;
	

	if
	:: 1 > 0 -> 
		ready.size = 1;
		run AsyncChan(ready)
	:: else -> 
		run sync_monitor(ready)
	fi;
	

	if
	:: 1 > 0 -> 
		check.size = 1;
		run AsyncChan(check)
	:: else -> 
		run sync_monitor(check)
	fi;
	

	if
	:: 1 > 0 -> 
		done.size = 1;
		run AsyncChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	run timerLoop85(ready,check,child_timerLoop850);
	run run95(ready,check,done,child_run951);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype timerLoop85(Chandef ready;Chandef check;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		

		if
		:: ready.deq?state,num_msgs;
		:: ready.sync?state -> 
			ready.rcving!false
		fi;
		

		if
		:: check.enq!0;
		:: check.sync!false -> 
			check.sending!false
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype run95(Chandef ready;Chandef check;Chandef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: ready.enq!0;
	:: ready.sync!false -> 
		ready.sending!false
	fi;
	do
	:: true -> 
		for20: skip;
		do
		:: true -> 
			goto stop_process
		:: check.deq?state,num_msgs -> 
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: ready.enq!0;
			:: ready.sync!false -> 
				ready.sending!false
			fi;
			break
		:: check.sync?state -> 
			check.rcving!false;
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: ready.enq!0;
			:: ready.sync!false -> 
				ready.sending!false
			fi;
			break
		od;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip;
		

	if
	:: done.enq!0;
	:: done.sync!false -> 
		done.sending!false
	fi;
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

