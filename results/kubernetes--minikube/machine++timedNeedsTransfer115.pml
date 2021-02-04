
// https://github.com/kubernetes/minikube/blob/caf59caaea357eef1ac1811ec514d883297523b6/pkg/minikube/machine/cache_images.go#L115
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef transferFinished;
	Chandef timeout;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 1 > 0 -> 
		timeout.size = 1;
		run AsyncChan(timeout)
	:: else -> 
		run sync_monitor(timeout)
	fi;
	run go_Anonymous0(timeout);
	

	if
	:: 1 > 0 -> 
		transferFinished.size = 1;
		run AsyncChan(transferFinished)
	:: else -> 
		run sync_monitor(transferFinished)
	fi;
	run go_Anonymous1(timeout,transferFinished);
	do
	:: transferFinished.async_rcv?state,num_msgs -> 
		goto stop_process
	:: transferFinished.sync?state,num_msgs -> 
		goto stop_process
	:: timeout.async_rcv?state,num_msgs -> 
		goto stop_process
	:: timeout.sync?state,num_msgs -> 
		goto stop_process
	od
stop_process:skip
}

proctype go_Anonymous0(Chandef timeout) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: timeout.async_send!0;
	:: timeout.sync!false,0 -> 
		timeout.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef timeout;Chandef transferFinished) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: transferFinished.async_send!0;
	:: transferFinished.sync!false,0 -> 
		transferFinished.sending?state
	fi;
	stop_process: skip
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
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;  // sending channel is open
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
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

