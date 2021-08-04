// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/k6io/k6/blob/af1e032ebf949cde092d4a2eddb78528ea0a5864/js/modules/k6/k6_test.go#L110
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
	chan child_TestGroup1100 = [1] of {int};
	run TestGroup110(child_TestGroup1100);
	run receiver(child_TestGroup1100)
stop_process:skip
}

proctype TestGroup110(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Bind1372 = [1] of {int};
	chan child_WithRuntime371 = [1] of {int};
	chan child_WithState310 = [1] of {int};
	Mutexdef state_RPSLimit_mu;
	Mutexdef state_TLSConfig_mutex;
	Mutexdef state_CookieJar_mu;
	Mutexdef state_Group_checkMutex;
	Mutexdef state_Group_groupMutex;
	Chandef state_Samples_ch;
	Mutexdef rt_vm_interruptLock;
	Mutexdef root_checkMutex;
	Mutexdef root_groupMutex;
	run mutexMonitor(root_groupMutex);
	run mutexMonitor(root_checkMutex);
	run mutexMonitor(rt_vm_interruptLock);
	

	if
	:: 1000 > 0 -> 
		state_Samples_ch.size = 1000;
		run AsyncChan(state_Samples_ch)
	:: else -> 
		run sync_monitor(state_Samples_ch)
	fi;
	run mutexMonitor(state_Group_groupMutex);
	run mutexMonitor(state_Group_checkMutex);
	run mutexMonitor(state_CookieJar_mu);
	run mutexMonitor(state_TLSConfig_mutex);
	run mutexMonitor(state_RPSLimit_mu);
	run WithState31(state_Samples_ch,state_CookieJar_mu,state_Group_checkMutex,state_Group_groupMutex,state_RPSLimit_mu,state_TLSConfig_mutex,child_WithState310);
	child_WithState310?0;
	run WithRuntime37(rt_vm_interruptLock,child_WithRuntime371);
	child_WithRuntime371?0;
	run Bind137(rt_vm_interruptLock,child_Bind1372);
	child_Bind1372?0;
	stop_process: skip;
	child!0
}
proctype WithState31(Chandef state_Samples_ch;Mutexdef state_CookieJar_mu;Mutexdef state_Group_checkMutex;Mutexdef state_Group_groupMutex;Mutexdef state_RPSLimit_mu;Mutexdef state_TLSConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype WithRuntime37(Mutexdef rt_vm_interruptLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Bind137(Mutexdef rt_vm_interruptLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_typ_NumField = -2; // opt var_typ_NumField
	int var_varArgsLen = -2; // opt var_varArgsLen
	int var_numIn = -2; // opt var_numIn
	int var_typ_NumMethod = -2; // opt var_typ_NumMethod
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

