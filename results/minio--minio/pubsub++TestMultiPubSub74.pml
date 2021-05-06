
// https://github.com/minio/minio/blob/master/pkg/pubsub/pubsub_test.go#L74
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
	chan child_TestMultiPubSub740 = [1] of {int};
	run TestMultiPubSub74(child_TestMultiPubSub740)
stop_process:skip
}

proctype TestMultiPubSub74(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Subscribe551 = [1] of {int};
	chan child_Subscribe550 = [1] of {int};
	Chandef doneCh;
	Chandef ch2;
	Chandef ch1;
	

	if
	:: 1 > 0 -> 
		ch1.size = 1;
		run AsyncChan(ch1)
	:: else -> 
		run sync_monitor(ch1)
	fi;
	

	if
	:: 1 > 0 -> 
		ch2.size = 1;
		run AsyncChan(ch2)
	:: else -> 
		run sync_monitor(ch2)
	fi;
	run sync_monitor(doneCh);
	run Subscribe55(ch1,doneCh,child_Subscribe550);
	child_Subscribe550?0;
	run Subscribe55(ch2,doneCh,child_Subscribe551);
	child_Subscribe551?0;
	

	if
	:: ch1.deq?state,num_msgs;
	:: ch1.sync?state -> 
		ch1.rcving!false
	fi;
	

	if
	:: ch2.deq?state,num_msgs;
	:: ch2.sync?state -> 
		ch2.rcving!false
	fi;
	stop_process: skip;
		doneCh.closing!true;
	child!0
}
proctype Subscribe55(Chandef subCh;Chandef doneCh;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousSubscribe63550 = [1] of {int};
	run AnonymousSubscribe6355(subCh,doneCh,child_AnonymousSubscribe63550);
	stop_process: skip;
	child!0
}
proctype AnonymousSubscribe6355(Chandef subCh;Chandef doneCh;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: doneCh.deq?state,num_msgs;
	:: doneCh.sync?state -> 
		doneCh.rcving!false
	fi;
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

