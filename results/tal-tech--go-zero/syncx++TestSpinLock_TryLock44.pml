// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/syncx/spinlock_test.go#L44
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
	chan child_TestSpinLock_TryLock440 = [1] of {int};
	run TestSpinLock_TryLock44(child_TestSpinLock_TryLock440);
	run receiver(child_TestSpinLock_TryLock440)
stop_process:skip
}

proctype TestSpinLock_TryLock44(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestSpinLock_TryLock60491 = [1] of {int};
	chan child_AnonymousTestSpinLock_TryLock51490 = [1] of {int};
	Chandef sig_ch;
	Wgdef wait;
	run wgMonitor(wait);
	wait.update!2;
	run sync_monitor(sig_ch);
	run AnonymousTestSpinLock_TryLock5149(sig_ch,wait,child_AnonymousTestSpinLock_TryLock51490);
	run receiver(child_AnonymousTestSpinLock_TryLock51490);
	run AnonymousTestSpinLock_TryLock6049(sig_ch,wait,child_AnonymousTestSpinLock_TryLock60491);
	run receiver(child_AnonymousTestSpinLock_TryLock60491);
	wait.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSpinLock_TryLock5149(Chandef sig_ch;Wgdef wait;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: sig_ch.enq!0;
	:: sig_ch.sync!false -> 
		sig_ch.sending!false
	fi;
	wait.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSpinLock_TryLock6049(Chandef sig_ch;Wgdef wait;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: sig_ch.deq?state,num_msgs;
	:: sig_ch.sync?state -> 
		sig_ch.rcving!false
	fi;
	wait.update!-1;
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

