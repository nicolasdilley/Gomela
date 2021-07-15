
// https://github.com/hashicorp/terraform/blob/master/terraform/context_test.go#L444
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
	chan child_testCheckDeadlock4440 = [1] of {int};
	run testCheckDeadlock444(child_testCheckDeadlock4440)
stop_process:skip
}

proctype testCheckDeadlock444(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoustestCheckDeadlock4524521 = [1] of {int};
	chan child_AnonymoustestCheckDeadlock4484460 = [1] of {int};
	Chandef done;
	Chandef timeout;
	

	if
	:: 1 > 0 -> 
		timeout.size = 1;
		run AsyncChan(timeout)
	:: else -> 
		run sync_monitor(timeout)
	fi;
	

	if
	:: 1 > 0 -> 
		done.size = 1;
		run AsyncChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	run AnonymoustestCheckDeadlock448446(timeout,done,child_AnonymoustestCheckDeadlock4484460);
	run AnonymoustestCheckDeadlock452452(done,timeout,child_AnonymoustestCheckDeadlock4524521);
	do
	:: timeout.deq?state,num_msgs -> 
		break
	:: timeout.sync?state -> 
		timeout.rcving!false;
		break
	:: done.deq?state,num_msgs -> 
		break
	:: done.sync?state -> 
		done.rcving!false;
		break
	od;
	stop_process: skip;
	child!0
}
proctype AnonymoustestCheckDeadlock448446(Chandef timeout;Chandef done;chan child) {
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
proctype AnonymoustestCheckDeadlock452452(Chandef done;Chandef timeout;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		

	if
	:: done.enq!0;
	:: done.sync!false -> 
		done.sending!false
	fi;
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

