
// https://github.com/moby/moby/blob/master/integration/container/exec_test.go#L19
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
	chan child_TestExecWithCloseStdin190 = [1] of {int};
	run TestExecWithCloseStdin19(child_TestExecWithCloseStdin190)
stop_process:skip
}

proctype TestExecWithCloseStdin19(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestExecWithCloseStdin59520 = [1] of {int};
	Chandef resCh;
	Chandef waitCh;
	run sync_monitor(waitCh);
	

	if
	:: 1 > 0 -> 
		resCh.size = 1;
		run AsyncChan(resCh)
	:: else -> 
		run sync_monitor(resCh)
	fi;
	run AnonymousTestExecWithCloseStdin5952(waitCh,resCh,child_AnonymousTestExecWithCloseStdin59520);
	

	if
	:: waitCh.deq?state,num_msgs;
	:: waitCh.sync?state -> 
		waitCh.rcving!false
	fi;
	do
	:: true -> 
		break
	:: resCh.deq?state,num_msgs -> 
		break
	:: resCh.sync?state -> 
		resCh.rcving!false;
		break
	od;
	stop_process: skip;
	child!0
}
proctype AnonymousTestExecWithCloseStdin5952(Chandef waitCh;Chandef resCh;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	waitCh.closing!true;
	

	if
	:: resCh.enq!0;
	:: resCh.sync!false -> 
		resCh.sending!false
	fi;
	stop_process: skip;
		resCh.closing!true;
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

