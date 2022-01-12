// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/traefik/traefik/blob//pkg/safe/routine_test.go#L96
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
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestPoolCleanupWithGoPanicking960 = [1] of {int};
	run TestPoolCleanupWithGoPanicking96(child_TestPoolCleanupWithGoPanicking960);
	run receiver(child_TestPoolCleanupWithGoPanicking960)
stop_process:skip
}

proctype TestPoolCleanupWithGoPanicking96(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestPoolCleanupWithGoPanicking1071061 = [1] of {int};
	Chandef testDone_ch;
	chan child_GoCtx320 = [1] of {int};
	Wgdef p_waitGroup;
	run wgMonitor(p_waitGroup);
	run GoCtx32(p_waitGroup,child_GoCtx320);
	child_GoCtx320?0;
	

	if
	:: 1 > 0 -> 
		testDone_ch.size = 1;
		run AsyncChan(testDone_ch)
	:: else -> 
		run sync_monitor(testDone_ch)
	fi;
	run AnonymousTestPoolCleanupWithGoPanicking107106(testDone_ch,p_waitGroup,child_AnonymousTestPoolCleanupWithGoPanicking1071061);
	run receiver(child_AnonymousTestPoolCleanupWithGoPanicking1071061);
	do
	:: true -> 
		break
	:: testDone_ch.deq?state,num_msgs -> 
		goto stop_process
	:: testDone_ch.sync?state -> 
		testDone_ch.rcving!false;
		goto stop_process
	od;
	for10_exit: skip;
	for10_end: skip;
	stop_process: skip;
	child!0
}
proctype GoCtx32(Wgdef p_waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_waitGroup.update!1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestPoolCleanupWithGoPanicking107106(Chandef testDone_ch;Wgdef p_waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop411 = [1] of {int};
	run Stop41(p_waitGroup,child_Stop411);
	child_Stop411?0;
	

	if
	:: testDone_ch.enq!0;
	:: testDone_ch.sync!false -> 
		testDone_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype Stop41(Wgdef p_waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_waitGroup.wait?0;
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
  :: ch.num_msgs > 0 -> // cannot send on closed channel
    end4: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.deq!true,ch.num_msgs -> 
  		 ch.num_msgs = ch.num_msgs - 1
    fi;
  :: else ->    end5: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.sync!true; 
    fi;
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

proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

proctype receiver(chan c) {
c?0
}

