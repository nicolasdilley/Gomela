
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/dockershim/libdocker/kube_docker_client.go#L580
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
	chan child_holdHijackedConnection5800 = [1] of {int};
	run holdHijackedConnection580(child_holdHijackedConnection5800)
stop_process:skip
}

proctype holdHijackedConnection580(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousholdHijackedConnection5895811 = [1] of {int};
	Chandef stdinDone;
	chan child_AnonymousholdHijackedConnection5835810 = [1] of {int};
	Chandef receiveStdout;
	run sync_monitor(receiveStdout);
	

	if
	:: true -> 
		run AnonymousholdHijackedConnection583581(receiveStdout,child_AnonymousholdHijackedConnection5835810)
	:: true;
	fi;
	run sync_monitor(stdinDone);
	run AnonymousholdHijackedConnection589581(receiveStdout,stdinDone,child_AnonymousholdHijackedConnection5895811);
	do
	:: receiveStdout.deq?state,num_msgs -> 
		goto stop_process
	:: receiveStdout.sync?state -> 
		receiveStdout.rcving!false;
		goto stop_process
	:: stdinDone.deq?state,num_msgs -> 
		

		if
		:: true -> 
			

			if
			:: receiveStdout.deq?state,num_msgs;
			:: receiveStdout.sync?state -> 
				receiveStdout.rcving!false
			fi;
			goto stop_process
		:: true;
		fi;
		break
	:: stdinDone.sync?state -> 
		stdinDone.rcving!false;
		

		if
		:: true -> 
			

			if
			:: receiveStdout.deq?state,num_msgs;
			:: receiveStdout.sync?state -> 
				receiveStdout.rcving!false
			fi;
			goto stop_process
		:: true;
		fi;
		break
	od;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousholdHijackedConnection583581(Chandef receiveStdout;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: receiveStdout.enq!0;
	:: receiveStdout.sync!false -> 
		receiveStdout.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousholdHijackedConnection589581(Chandef receiveStdout;Chandef stdinDone;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stdinDone.closing!true;
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

