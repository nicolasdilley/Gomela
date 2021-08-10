// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/uber-go/zap/blob/7b21229fb3f063275f4f169f8a79ad30aa001c51/level_test.go#L60
#define not_found_66  1 // mand goroutines line 47
#define not_found_70  1 // mand goroutines line 47
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
	chan child_TestAtomicLevelMutation600 = [1] of {int};
	run TestAtomicLevelMutation60(child_TestAtomicLevelMutation600);
	run receiver(child_TestAtomicLevelMutation600)
stop_process:skip
}

proctype TestAtomicLevelMutation60(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runConcurrently471 = [1] of {int};
	chan child_runConcurrently470 = [1] of {int};
	Wgdef wg;
	Chandef proceed_ch;
	run sync_monitor(proceed_ch);
	run wgMonitor(wg);
	run runConcurrently47(wg,not_found_66,child_runConcurrently470);
	child_runConcurrently470?0;
	run runConcurrently47(wg,not_found_70,child_runConcurrently471);
	child_runConcurrently471?0;
	proceed_ch.closing!true;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype runConcurrently47(Wgdef wg;int var_goroutines;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousrunConcurrently50470 = [1] of {int};
	wg.update!var_goroutines;
		for(i : 0.. var_goroutines-1) {
		for10: skip;
		run AnonymousrunConcurrently5047(wg,child_AnonymousrunConcurrently50470);
		run receiver(child_AnonymousrunConcurrently50470);
		for10_end: skip
	};
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousrunConcurrently5047(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_iterations = -2; // opt var_iterations
		defer1: skip;
	wg.update!-1;
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

