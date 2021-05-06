
// https://github.com/hashicorp/terraform/blob/master/internal/legacy/helper/schema/provisioner_test.go#L260
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
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProvisionerStop_apply2600 = [1] of {int};
	run TestProvisionerStop_apply260(child_TestProvisionerStop_apply2600)
stop_process:skip
}

proctype TestProvisionerStop_apply260(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop1181 = [1] of {int};
	chan child_AnonymousTestProvisionerStop_apply2992980 = [1] of {int};
	Chandef doneCh;
	Mutexdef state_mu;
	Mutexdef p_stopOnce_m;
	run mutexMonitor(p_stopOnce_m);
	run mutexMonitor(state_mu);
	run sync_monitor(doneCh);
	run AnonymousTestProvisionerStop_apply299298(doneCh,p_stopOnce_m,state_mu,child_AnonymousTestProvisionerStop_apply2992980);
	do
	:: doneCh.deq?state,num_msgs -> 
		break
	:: doneCh.sync?state -> 
		doneCh.rcving!false;
		break
	:: true -> 
		break
	od;
	run Stop118(p_stopOnce_m,child_Stop1181);
	child_Stop1181?0;
	do
	:: doneCh.deq?state,num_msgs -> 
		break
	:: doneCh.sync?state -> 
		doneCh.rcving!false;
		break
	:: true -> 
		break
	od;
	stop_process: skip;
	child!0
}
proctype AnonymousTestProvisionerStop_apply299298(Chandef doneCh;Mutexdef p_stopOnce_m;Mutexdef state_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Apply1300 = [1] of {int};
	run Apply130(p_stopOnce_m,state_mu,child_Apply1300);
	child_Apply1300?0;
	doneCh.closing!true;
	stop_process: skip;
	child!0
}
proctype Apply130(Mutexdef p_stopOnce_m;Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StopContext1080 = [1] of {int};
	Mutexdef configData_once_m;
	Mutexdef configData_newState_mu;
	Mutexdef configData_setWriter_lock;
	Mutexdef configData_diff_mu;
	Mutexdef configData_state_mu;
	Mutexdef connData_once_m;
	Mutexdef connData_newState_mu;
	Mutexdef connData_setWriter_lock;
	Mutexdef connData_diff_mu;
	Mutexdef connData_state_mu;
	run mutexMonitor(connData_state_mu);
	run mutexMonitor(connData_diff_mu);
	run mutexMonitor(connData_setWriter_lock);
	run mutexMonitor(connData_newState_mu);
	run mutexMonitor(connData_once_m);
	run mutexMonitor(configData_state_mu);
	run mutexMonitor(configData_diff_mu);
	run mutexMonitor(configData_setWriter_lock);
	run mutexMonitor(configData_newState_mu);
	run mutexMonitor(configData_once_m);
	run StopContext108(p_stopOnce_m,child_StopContext1080);
	child_StopContext1080?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype StopContext108(Mutexdef p_stopOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Stop118(Mutexdef p_stopOnce_m;chan child) {
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

proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

