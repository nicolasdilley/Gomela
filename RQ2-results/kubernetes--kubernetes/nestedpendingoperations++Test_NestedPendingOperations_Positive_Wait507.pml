
// https://github.com/kubernetes/kubernetes/blob/master/pkg/volume/util/nestedpendingoperations/nestedpendingoperations_test.go#L507
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
	chan child_Test_NestedPendingOperations_Positive_Wait5070 = [1] of {int};
	run Test_NestedPendingOperations_Positive_Wait507(child_Test_NestedPendingOperations_Positive_Wait5070)
stop_process:skip
}

proctype Test_NestedPendingOperations_Positive_Wait507(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_waitChannelWithTimeout8702 = [1] of {int};
	chan child_AnonymousTest_NestedPendingOperations_Positive_Wait5215121 = [1] of {int};
	Chandef waitDoneCh;
	chan child_generateWaitFunc8340 = [1] of {int};
	Chandef operation1DoneCh;
	run sync_monitor(operation1DoneCh);
	run generateWaitFunc834(operation1DoneCh,child_generateWaitFunc8340);
	child_generateWaitFunc8340?0;
	

	if
	:: 1 > 0 -> 
		waitDoneCh.size = 1;
		run AsyncChan(waitDoneCh)
	:: else -> 
		run sync_monitor(waitDoneCh)
	fi;
	run AnonymousTest_NestedPendingOperations_Positive_Wait521512(operation1DoneCh,waitDoneCh,child_AnonymousTest_NestedPendingOperations_Positive_Wait5215121);
	

	if
	:: operation1DoneCh.enq!0;
	:: operation1DoneCh.sync!false -> 
		operation1DoneCh.sending!false
	fi;
	run waitChannelWithTimeout870(waitDoneCh,child_waitChannelWithTimeout8702);
	child_waitChannelWithTimeout8702?0;
	stop_process: skip;
	child!0
}
proctype generateWaitFunc834(Chandef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTest_NestedPendingOperations_Positive_Wait521512(Chandef operation1DoneCh;Chandef waitDoneCh;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: waitDoneCh.enq!0;
	:: waitDoneCh.sync!false -> 
		waitDoneCh.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype waitChannelWithTimeout870(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: ch.deq?state,num_msgs -> 
		goto stop_process
	:: ch.sync?state -> 
		ch.rcving!false;
		goto stop_process
	:: true -> 
		goto stop_process
	od;
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

