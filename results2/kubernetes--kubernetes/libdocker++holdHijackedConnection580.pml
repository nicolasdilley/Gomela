// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/dockershim/libdocker/kube_docker_client.go#L580
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
	run holdHijackedConnection580(child_holdHijackedConnection5800);
	run receiver(child_holdHijackedConnection5800)
stop_process:skip
}

proctype holdHijackedConnection580(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousholdHijackedConnection5895811 = [1] of {int};
	Chandef stdinDone_ch;
	chan child_AnonymousholdHijackedConnection5835810 = [1] of {int};
	Chandef receiveStdout_ch;
	run sync_monitor(receiveStdout_ch);
	

	if
	:: true -> 
		run AnonymousholdHijackedConnection583581(receiveStdout_ch,child_AnonymousholdHijackedConnection5835810);
		run receiver(child_AnonymousholdHijackedConnection5835810)
	:: true;
	fi;
	run sync_monitor(stdinDone_ch);
	run AnonymousholdHijackedConnection589581(receiveStdout_ch,stdinDone_ch,child_AnonymousholdHijackedConnection5895811);
	run receiver(child_AnonymousholdHijackedConnection5895811);
	do
	:: receiveStdout_ch.deq?state,num_msgs -> 
		goto stop_process
	:: receiveStdout_ch.sync?state -> 
		receiveStdout_ch.rcving!false;
		goto stop_process
	:: stdinDone_ch.deq?state,num_msgs -> 
		

		if
		:: true -> 
			

			if
			:: receiveStdout_ch.deq?state,num_msgs;
			:: receiveStdout_ch.sync?state -> 
				receiveStdout_ch.rcving!false
			fi;
			goto stop_process
		:: true;
		fi;
		break
	:: stdinDone_ch.sync?state -> 
		stdinDone_ch.rcving!false;
		

		if
		:: true -> 
			

			if
			:: receiveStdout_ch.deq?state,num_msgs;
			:: receiveStdout_ch.sync?state -> 
				receiveStdout_ch.rcving!false
			fi;
			goto stop_process
		:: true;
		fi;
		break
	od;
	for10_exit: skip;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousholdHijackedConnection583581(Chandef receiveStdout_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: receiveStdout_ch.enq!0;
	:: receiveStdout_ch.sync!false -> 
		receiveStdout_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousholdHijackedConnection589581(Chandef receiveStdout_ch;Chandef stdinDone_ch;chan child) {
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

