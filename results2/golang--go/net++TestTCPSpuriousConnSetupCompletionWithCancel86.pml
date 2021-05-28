// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/tcpsock_unix_test.go#L86
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
	chan child_TestTCPSpuriousConnSetupCompletionWithCancel860 = [1] of {int};
	run TestTCPSpuriousConnSetupCompletionWithCancel86(child_TestTCPSpuriousConnSetupCompletionWithCancel860);
	run receiver(child_TestTCPSpuriousConnSetupCompletionWithCancel860)
stop_process:skip
}

proctype TestTCPSpuriousConnSetupCompletionWithCancel86(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestTCPSpuriousConnSetupCompletionWithCancel1031031 = [1] of {int};
	chan child_AnonymousTestTCPSpuriousConnSetupCompletionWithCancel98940 = [1] of {int};
	Chandef sem;
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!10000 * 2;
	

	if
	:: 5 > 0 -> 
		sem.size = 5;
		run AsyncChan(sem)
	:: else -> 
		run sync_monitor(sem)
	fi;
		for(i : 0.. 10000-1) {
		for10: skip;
		

		if
		:: sem.enq!0;
		:: sem.sync!false -> 
			sem.sending!false
		fi;
		run AnonymousTestTCPSpuriousConnSetupCompletionWithCancel9894(sem,wg,child_AnonymousTestTCPSpuriousConnSetupCompletionWithCancel98940);
		run receiver(child_AnonymousTestTCPSpuriousConnSetupCompletionWithCancel98940);
		run AnonymousTestTCPSpuriousConnSetupCompletionWithCancel103103(sem,wg,child_AnonymousTestTCPSpuriousConnSetupCompletionWithCancel1031031);
		run receiver(child_AnonymousTestTCPSpuriousConnSetupCompletionWithCancel1031031);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTCPSpuriousConnSetupCompletionWithCancel9894(Chandef sem;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTCPSpuriousConnSetupCompletionWithCancel103103(Chandef sem;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: sem.deq?state,num_msgs;
	:: sem.sync?state -> 
		sem.rcving!false
	fi;
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

