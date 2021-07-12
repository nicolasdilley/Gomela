// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/tcpsock_unix_test.go#L21
#define TestTCPSpuriousConnSetupCompletion_attempts  ??
#define TestTCPSpuriousConnSetupCompletion_runtime_GOMAXPROCS_1_  ??
#define ub_for34_3  ??
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
	chan child_TestTCPSpuriousConnSetupCompletion210 = [1] of {int};
	run TestTCPSpuriousConnSetupCompletion21(child_TestTCPSpuriousConnSetupCompletion210);
	run receiver(child_TestTCPSpuriousConnSetupCompletion210)
stop_process:skip
}

proctype TestTCPSpuriousConnSetupCompletion21(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestTCPSpuriousConnSetupCompletion54541 = [1] of {int};
	Chandef throttle_ch;
	chan child_AnonymousTestTCPSpuriousConnSetupCompletion32320 = [1] of {int};
	Wgdef wg;
	int var_runtime_GOMAXPROCS_1_ = TestTCPSpuriousConnSetupCompletion_runtime_GOMAXPROCS_1_; // mand var_runtime_GOMAXPROCS_1_
	int var_attempts = TestTCPSpuriousConnSetupCompletion_attempts; // mand var_attempts
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestTCPSpuriousConnSetupCompletion3232(wg,child_AnonymousTestTCPSpuriousConnSetupCompletion32320);
	run receiver(child_AnonymousTestTCPSpuriousConnSetupCompletion32320);
	wg.update!var_attempts;
	

	if
	:: var_runtime_GOMAXPROCS_1_ * 2 > 0 -> 
		throttle_ch.size = var_runtime_GOMAXPROCS_1_ * 2;
		run AsyncChan(throttle_ch)
	:: else -> 
		run sync_monitor(throttle_ch)
	fi;
		for(i : 0.. var_attempts-1) {
		for20: skip;
		

		if
		:: throttle_ch.enq!0;
		:: throttle_ch.sync!false -> 
			throttle_ch.sending!false
		fi;
		run AnonymousTestTCPSpuriousConnSetupCompletion5454(throttle_ch,wg,child_AnonymousTestTCPSpuriousConnSetupCompletion54541);
		run receiver(child_AnonymousTestTCPSpuriousConnSetupCompletion54541);
		for20_end: skip
	};
	for20_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTCPSpuriousConnSetupCompletion3232(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousAnonymousTestTCPSpuriousConnSetupCompletion3240400 = [1] of {int};
		for(i : 0.. ub_for34_3) {
		for10: skip;
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		wg.update!1;
		run AnonymousAnonymousTestTCPSpuriousConnSetupCompletion324040(wg,child_AnonymousAnonymousTestTCPSpuriousConnSetupCompletion3240400);
		run receiver(child_AnonymousAnonymousTestTCPSpuriousConnSetupCompletion3240400);
		for10_end: skip
	};
	for10_exit: skip;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousAnonymousTestTCPSpuriousConnSetupCompletion324040(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTCPSpuriousConnSetupCompletion5454(Chandef throttle_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	

	if
	:: throttle_ch.deq?state,num_msgs;
	:: throttle_ch.sync?state -> 
		throttle_ch.rcving!false
	fi;
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

