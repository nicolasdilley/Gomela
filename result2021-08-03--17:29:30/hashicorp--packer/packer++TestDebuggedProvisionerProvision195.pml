// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/packer/blob/a9c2283ee589b203c0ce16174a5747b7d2053d61/packer/provisioner_test.go#L195
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
	run TestDebuggedProvisionerProvision195(child_TestDebuggedProvisionerProvision1950);
	run receiver(child_TestDebuggedProvisionerProvision1950)
stop_process:skip
}

proctype TestDebuggedProvisionerProvision195(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provision2171 = [1] of {int};
	chan child_writeReader220 = [1] of {int};
	Mutexdef comm_StartCmd_m;
	Mutexdef ui_l;
	Mutexdef prov_lock;
	run mutexMonitor(prov_lock);
	run mutexMonitor(ui_l);
	run mutexMonitor(comm_StartCmd_m);
	run writeReader22(ui_l,child_writeReader220);
	child_writeReader220?0;
	run Provision217(prov_lock,ui_l,comm_StartCmd_m,child_Provision2171);
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
proctype Provision217(Mutexdef p_lock;Mutexdef ui_l;Mutexdef comm_StartCmd_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousProvision2222211 = [1] of {int};
	Chandef result_ch;
	

	if
	:: 1 > 0 -> 
		result_ch.size = 1;
		run AsyncChan(result_ch)
	:: else -> 
		run sync_monitor(result_ch)
	fi;
	run AnonymousProvision222221(result_ch,p_lock,ui_l,comm_StartCmd_m,child_AnonymousProvision2222211);
	run receiver(child_AnonymousProvision2222211);
	do
	:: result_ch.deq?state,num_msgs -> 
		break
	:: result_ch.sync?state -> 
		result_ch.rcving!false;
		break
	:: true -> 
		goto stop_process
	od;
	for10_exit: skip;
	for10_end: skip;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousProvision222221(Chandef result_ch;Mutexdef p_lock;Mutexdef ui_l;Mutexdef comm_StartCmd_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: result_ch.enq!0;
	:: result_ch.sync!false -> 
		result_ch.sending!false
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

proctype receiver(chan c) {
c?0
}

