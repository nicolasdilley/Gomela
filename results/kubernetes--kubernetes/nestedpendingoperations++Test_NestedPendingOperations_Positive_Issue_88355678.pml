
// https://github.com/kubernetes/kubernetes/blob/master/pkg/volume/util/nestedpendingoperations/nestedpendingoperations_test.go#L678
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
	chan child_Test_NestedPendingOperations_Positive_Issue_883556780 = [1] of {int};
	run Test_NestedPendingOperations_Positive_Issue_88355678(child_Test_NestedPendingOperations_Positive_Issue_883556780)
stop_process:skip
}

proctype Test_NestedPendingOperations_Positive_Issue_88355678(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_generateWaitWithErrorFunc8492 = [1] of {int};
	chan child_generateWaitFunc8341 = [1] of {int};
	chan child_generateWaitFunc8340 = [1] of {int};
	Chandef op2ContinueCh;
	Chandef op1ContinueCh;
	Chandef opZContinueCh;
	run sync_monitor(opZContinueCh);
	run sync_monitor(op1ContinueCh);
	run sync_monitor(op2ContinueCh);
	run generateWaitFunc834(opZContinueCh,child_generateWaitFunc8340);
	child_generateWaitFunc8340?0;
	run generateWaitFunc834(op1ContinueCh,child_generateWaitFunc8341);
	child_generateWaitFunc8341?0;
	run generateWaitWithErrorFunc849(op2ContinueCh,child_generateWaitWithErrorFunc8492);
	child_generateWaitWithErrorFunc8492?0;
	

	if
	:: opZContinueCh.enq!0;
	:: opZContinueCh.sync!false -> 
		opZContinueCh.sending!false
	fi;
	

	if
	:: op2ContinueCh.enq!0;
	:: op2ContinueCh.sync!false -> 
		op2ContinueCh.sending!false
	fi;
	

	if
	:: op1ContinueCh.enq!0;
	:: op1ContinueCh.sync!false -> 
		op1ContinueCh.sending!false
	fi;
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
proctype generateWaitWithErrorFunc849(Chandef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
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
