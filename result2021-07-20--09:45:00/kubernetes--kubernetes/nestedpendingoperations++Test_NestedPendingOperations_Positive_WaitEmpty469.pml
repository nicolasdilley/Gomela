// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/volume/util/nestedpendingoperations/nestedpendingoperations_test.go#L469
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
	chan child_Test_NestedPendingOperations_Positive_WaitEmpty4690 = [1] of {int};
	run Test_NestedPendingOperations_Positive_WaitEmpty469(child_Test_NestedPendingOperations_Positive_WaitEmpty4690);
	run receiver(child_Test_NestedPendingOperations_Positive_WaitEmpty4690)
stop_process:skip
}

proctype Test_NestedPendingOperations_Positive_WaitEmpty469(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_waitChannelWithTimeout8701 = [1] of {int};
	chan child_AnonymousTest_NestedPendingOperations_Positive_WaitEmpty4764750 = [1] of {int};
	Chandef waitDoneCh_ch;
	

	if
	:: 1 > 0 -> 
		waitDoneCh_ch.size = 1;
		run AsyncChan(waitDoneCh_ch)
	:: else -> 
		run sync_monitor(waitDoneCh_ch)
	fi;
	run AnonymousTest_NestedPendingOperations_Positive_WaitEmpty476475(waitDoneCh_ch,child_AnonymousTest_NestedPendingOperations_Positive_WaitEmpty4764750);
	run receiver(child_AnonymousTest_NestedPendingOperations_Positive_WaitEmpty4764750);
	run waitChannelWithTimeout870(waitDoneCh_ch,child_waitChannelWithTimeout8701);
	child_waitChannelWithTimeout8701?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTest_NestedPendingOperations_Positive_WaitEmpty476475(Chandef waitDoneCh_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: waitDoneCh_ch.enq!0;
	:: waitDoneCh_ch.sync!false -> 
		waitDoneCh_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype waitChannelWithTimeout870(Chandef ch_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: ch_ch.deq?state,num_msgs -> 
		goto stop_process
	:: ch_ch.sync?state -> 
		ch_ch.rcving!false;
		goto stop_process
	:: true -> 
		goto stop_process
	od;
	for10_exit: skip;
	for10_end: skip;
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

proctype receiver(chan c) {
c?0
}

