
// https://github.com/hashicorp/packer/blob/master/packer/provisioner_test.go#L195
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
	chan child_TestDebuggedProvisionerProvision1950 = [1] of {int};
	run TestDebuggedProvisionerProvision195(child_TestDebuggedProvisionerProvision1950)
stop_process:skip
}

proctype TestDebuggedProvisionerProvision195(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provision2171 = [1] of {int};
	chan child_writeReader220 = [1] of {int};
	Mutexdef comm_StartCmd_exitChInit_m;
	Mutexdef comm_StartCmd_m;
	Mutexdef ui_l;
	Mutexdef prov_lock;
	run mutexMonitor(prov_lock);
	run mutexMonitor(ui_l);
	run mutexMonitor(comm_StartCmd_m);
	run mutexMonitor(comm_StartCmd_exitChInit_m);
	run writeReader22(ui_l,child_writeReader220);
	child_writeReader220?0;
	run Provision217(prov_lock,ui_l,comm_StartCmd_m,comm_StartCmd_exitChInit_m,child_Provision2171);
	child_Provision2171?0;
	stop_process: skip;
	child!0
}
proctype writeReader22(Mutexdef ui_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Provision217(Mutexdef p_lock;Mutexdef ui_l;Mutexdef comm_StartCmd_m;Mutexdef comm_StartCmd_exitChInit_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provision342 = [1] of {int};
	chan child_AnonymousProvision2222211 = [1] of {int};
	Chandef result;
	

	if
	:: 1 > 0 -> 
		result.size = 1;
		run AsyncChan(result)
	:: else -> 
		run sync_monitor(result)
	fi;
	run AnonymousProvision222221(result,p_lock,ui_l,comm_StartCmd_m,comm_StartCmd_exitChInit_m,child_AnonymousProvision2222211);
	do
	:: result.deq?state,num_msgs -> 
		break
	:: result.sync?state -> 
		result.rcving!false;
		break
	:: true -> 
		goto stop_process
	od;
	run Provision34(ui_l,comm_StartCmd_m,comm_StartCmd_exitChInit_m,child_Provision342);
	child_Provision342?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousProvision222221(Chandef result;Mutexdef p_lock;Mutexdef ui_l;Mutexdef comm_StartCmd_m;Mutexdef comm_StartCmd_exitChInit_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Ask431 = [1] of {int};
	run Ask43(ui_l,child_Ask431);
	child_Ask431?0;
	

	if
	:: result.enq!0;
	:: result.sync!false -> 
		result.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype Ask43(Mutexdef u_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_colorize731 = [1] of {int};
	run colorize73(u_l,child_colorize731);
	child_colorize731?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype colorize73(Mutexdef u_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_supportsColors861 = [1] of {int};
	run supportsColors86(u_l,child_supportsColors861);
	child_supportsColors861?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype supportsColors86(Mutexdef u_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Provision34(Mutexdef ui_l;Mutexdef comm_StartCmd_m;Mutexdef comm_StartCmd_exitChInit_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provision342 = [1] of {int};
	run Provision34(ui_l,comm_StartCmd_m,comm_StartCmd_exitChInit_m,child_Provision342);
	child_Provision342?0;
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

