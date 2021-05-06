
// https://github.com/kubernetes/kubernetes/blob/master/cmd/kubeadm/app/util/apiclient/wait.go#L159
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
	chan child_WaitForKubeletAndFunc1590 = [1] of {int};
	run WaitForKubeletAndFunc159(child_WaitForKubeletAndFunc1590)
stop_process:skip
}

proctype WaitForKubeletAndFunc159(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousWaitForKubeletAndFunc1681681 = [1] of {int};
	chan child_AnonymousWaitForKubeletAndFunc1621620 = [1] of {int};
	Chandef errorChan;
	

	if
	:: 1 > 0 -> 
		errorChan.size = 1;
		run AsyncChan(errorChan)
	:: else -> 
		run sync_monitor(errorChan)
	fi;
	run AnonymousWaitForKubeletAndFunc162162(errorChan,child_AnonymousWaitForKubeletAndFunc1621620);
	run AnonymousWaitForKubeletAndFunc168168(errorChan,child_AnonymousWaitForKubeletAndFunc1681681);
	

	if
	:: errorChan.deq?state,num_msgs;
	:: errorChan.sync?state -> 
		errorChan.rcving!false
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousWaitForKubeletAndFunc162162(Chandef errC;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errC.enq!0;
		:: errC.sync!false -> 
			errC.sending!false
		fi
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousWaitForKubeletAndFunc168168(Chandef errC;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: errC.enq!0;
	:: errC.sync!false -> 
		errC.sending!false
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

