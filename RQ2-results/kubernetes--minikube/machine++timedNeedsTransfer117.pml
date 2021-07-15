
// https://github.com/kubernetes/minikube/blob/master/pkg/minikube/machine/cache_images.go#L117
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
	chan child_timedNeedsTransfer1170 = [1] of {int};
	run timedNeedsTransfer117(child_timedNeedsTransfer1170)
stop_process:skip
}

proctype timedNeedsTransfer117(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoustimedNeedsTransfer1261181 = [1] of {int};
	Chandef transferFinished;
	chan child_AnonymoustimedNeedsTransfer1191180 = [1] of {int};
	Chandef timeout;
	

	if
	:: 1 > 0 -> 
		timeout.size = 1;
		run AsyncChan(timeout)
	:: else -> 
		run sync_monitor(timeout)
	fi;
	run AnonymoustimedNeedsTransfer119118(timeout,child_AnonymoustimedNeedsTransfer1191180);
	

	if
	:: 1 > 0 -> 
		transferFinished.size = 1;
		run AsyncChan(transferFinished)
	:: else -> 
		run sync_monitor(transferFinished)
	fi;
	run AnonymoustimedNeedsTransfer126118(timeout,transferFinished,child_AnonymoustimedNeedsTransfer1261181);
	do
	:: transferFinished.deq?state,num_msgs -> 
		goto stop_process
	:: transferFinished.sync?state -> 
		transferFinished.rcving!false;
		goto stop_process
	:: timeout.deq?state,num_msgs -> 
		goto stop_process
	:: timeout.sync?state -> 
		timeout.rcving!false;
		goto stop_process
	od;
	stop_process: skip;
	child!0
}
proctype AnonymoustimedNeedsTransfer119118(Chandef timeout;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: timeout.enq!0;
	:: timeout.sync!false -> 
		timeout.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymoustimedNeedsTransfer126118(Chandef timeout;Chandef transferFinished;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: transferFinished.enq!0;
	:: transferFinished.sync!false -> 
		transferFinished.sending!false
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

