// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/util/goroutinemap/goroutinemap_test.go#L393
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
	chan child_Test_NewGoRoutineMap_Positive_Wait3930 = [1] of {int};
	run Test_NewGoRoutineMap_Positive_Wait393(child_Test_NewGoRoutineMap_Positive_Wait3930);
	run receiver(child_Test_NewGoRoutineMap_Positive_Wait3930)
stop_process:skip
}

proctype Test_NewGoRoutineMap_Positive_Wait393(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_waitChannelWithTimeout5202 = [1] of {int};
	chan child_AnonymousTest_NewGoRoutineMap_Positive_Wait4074061 = [1] of {int};
	Chandef waitDoneCh_ch;
	chan child_generateWaitFunc4930 = [1] of {int};
	Chandef operation1DoneCh_ch;
	

	if
	:: 0 > 0 -> 
		operation1DoneCh_ch.size = 0;
		run AsyncChan(operation1DoneCh_ch)
	:: else -> 
		run sync_monitor(operation1DoneCh_ch)
	fi;
	run generateWaitFunc493(operation1DoneCh_ch,child_generateWaitFunc4930);
	child_generateWaitFunc4930?0;
	

	if
	:: 1 > 0 -> 
		waitDoneCh_ch.size = 1;
		run AsyncChan(waitDoneCh_ch)
	:: else -> 
		run sync_monitor(waitDoneCh_ch)
	fi;
	run AnonymousTest_NewGoRoutineMap_Positive_Wait407406(waitDoneCh_ch,operation1DoneCh_ch,child_AnonymousTest_NewGoRoutineMap_Positive_Wait4074061);
	run receiver(child_AnonymousTest_NewGoRoutineMap_Positive_Wait4074061);
	

	if
	:: operation1DoneCh_ch.enq!0;
	:: operation1DoneCh_ch.sync!false -> 
		operation1DoneCh_ch.sending!false
	fi;
	run waitChannelWithTimeout520(waitDoneCh_ch,child_waitChannelWithTimeout5202);
	child_waitChannelWithTimeout5202?0;
	stop_process: skip;
	child!0
}
proctype generateWaitFunc493(Chandef done_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTest_NewGoRoutineMap_Positive_Wait407406(Chandef waitDoneCh_ch;Chandef operation1DoneCh_ch;chan child) {
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
proctype waitChannelWithTimeout520(Chandef ch_ch;chan child) {
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

