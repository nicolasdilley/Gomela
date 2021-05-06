
// https://github.com/prometheus/prometheus/blob/master/discovery/kubernetes/kubernetes_test.go#L63
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
	chan child_Run630 = [1] of {int};
	run Run63(child_Run630)
stop_process:skip
}

proctype Run63(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_readResultWithTimeout1151 = [1] of {int};
	Chandef resChan;
	chan child_Run1340 = [1] of {int};
	Chandef ch;
	run sync_monitor(ch);
	run Run134(ch,child_Run1340);
	run sync_monitor(resChan);
	run readResultWithTimeout115(ch,resChan,child_readResultWithTimeout1151);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: resChan.deq?state,num_msgs;
		:: resChan.sync?state -> 
			resChan.rcving!false
		fi
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype Run134(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousRun1441340 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run AnonymousRun144134(ch,child_AnonymousRun1441340);
	stop_process: skip;
	child!0
}
proctype AnonymousRun144134(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_process1530 = [1] of {int};
	run process153(ch,child_process1530);
	child_process1530?0;
	stop_process: skip;
	child!0
}
proctype process153(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_send5411 = [1] of {int};
	chan child_send5410 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run send541(ch,child_send5410);
		child_send5410?0;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run send541(ch,child_send5411);
	child_send5411?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype send541(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
		break
	:: ch.enq!0 -> 
		break
	:: ch.sync!false,0 -> 
		ch.sending!false;
		break
	od;
	stop_process: skip;
	child!0
}
proctype readResultWithTimeout115(Chandef ch;Chandef resChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for30: skip;
		do
		:: ch.deq?state,num_msgs -> 
			

			if
			:: true -> 
				goto Loop
			:: true;
			fi;
			break
		:: ch.sync?state -> 
			ch.rcving!false;
			

			if
			:: true -> 
				goto Loop
			:: true;
			fi;
			break
		:: true -> 
			goto Loop;
			break
		od;
		for30_end: skip
	od;
	for30_exit: skip;
	Loop: skip;
	

	if
	:: resChan.enq!0;
	:: resChan.sync!false -> 
		resChan.sending!false
	fi;
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

