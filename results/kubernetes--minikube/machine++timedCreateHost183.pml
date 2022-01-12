// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/minikube/blob//pkg/minikube/machine/start.go#L183
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
	chan child_timedCreateHost1830 = [1] of {int};
	run timedCreateHost183(child_timedCreateHost1830);
	run receiver(child_timedCreateHost1830)
stop_process:skip
}

proctype timedCreateHost183(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoustimedCreateHost1921841 = [1] of {int};
	Chandef createFinished_ch;
	chan child_AnonymoustimedCreateHost1851840 = [1] of {int};
	Chandef timeout_ch;
	

	if
	:: 1 > 0 -> 
		timeout_ch.size = 1;
		run AsyncChan(timeout_ch)
	:: else -> 
		run sync_monitor(timeout_ch)
	fi;
	run AnonymoustimedCreateHost185184(timeout_ch,child_AnonymoustimedCreateHost1851840);
	run receiver(child_AnonymoustimedCreateHost1851840);
	

	if
	:: 1 > 0 -> 
		createFinished_ch.size = 1;
		run AsyncChan(createFinished_ch)
	:: else -> 
		run sync_monitor(createFinished_ch)
	fi;
	run AnonymoustimedCreateHost192184(timeout_ch,createFinished_ch,child_AnonymoustimedCreateHost1921841);
	run receiver(child_AnonymoustimedCreateHost1921841);
	do
	:: createFinished_ch.deq?state,num_msgs -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: createFinished_ch.sync?state -> 
		createFinished_ch.rcving!false;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: timeout_ch.deq?state,num_msgs -> 
		goto stop_process
	:: timeout_ch.sync?state -> 
		timeout_ch.rcving!false;
		goto stop_process
	od;
	for10_exit: skip;
	for10_end: skip;
	stop_process: skip;
	child!0
}
proctype AnonymoustimedCreateHost185184(Chandef timeout_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: timeout_ch.enq!0;
	:: timeout_ch.sync!false -> 
		timeout_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymoustimedCreateHost192184(Chandef timeout_ch;Chandef createFinished_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: createFinished_ch.enq!0;
	:: createFinished_ch.sync!false -> 
		createFinished_ch.sending!false
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

