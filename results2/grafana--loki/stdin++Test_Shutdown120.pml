// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/grafana/loki/blob/aa544a9dffdb8e78f7d7ed8edafce466d333b0a8/clients/pkg/promtail/targets/stdin/stdin_target_manager_test.go#L120
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
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_Shutdown1200 = [1] of {int};
	run Test_Shutdown120(child_Test_Shutdown1200);
	run receiver(child_Test_Shutdown1200)
stop_process:skip
}

proctype Test_Shutdown120(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop931 = [1] of {int};
	chan child_NewStdinTargetManager610 = [1] of {int};
	Wgdef recorder_wg;
	Mutexdef recorder_mtx;
	Mutexdef recorder_once_m;
	Chandef appMock_called_ch;
	

	if
	:: 1 > 0 -> 
		appMock_called_ch.size = 1;
		run AsyncChan(appMock_called_ch)
	:: else -> 
		run sync_monitor(appMock_called_ch)
	fi;
	run mutexMonitor(recorder_once_m);
	run mutexMonitor(recorder_mtx);
	run wgMonitor(recorder_wg);
	run NewStdinTargetManager61(appMock_called_ch,recorder_wg,recorder_mtx,recorder_once_m,child_NewStdinTargetManager610);
	child_NewStdinTargetManager610?0;
	

	if
	:: appMock_called_ch.deq?state,num_msgs;
	:: appMock_called_ch.sync?state -> 
		appMock_called_ch.rcving!false
	fi;
	run Stop93(recorder_wg,recorder_mtx,recorder_once_m,child_Stop931);
	child_Stop931?0;
	stop_process: skip;
	child!0
}
proctype NewStdinTargetManager61(Chandef app_called_ch;Wgdef client_wg;Mutexdef client_mtx;Mutexdef client_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousNewStdinTargetManager7101 = [1] of {int};
	chan child_newReaderTarget1070 = [1] of {int};
	run newReaderTarget107(client_wg,client_mtx,client_once_m,child_newReaderTarget1070);
	child_newReaderTarget1070?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run AnonymousNewStdinTargetManager710(app_called_ch,client_wg,client_mtx,client_once_m,child_AnonymousNewStdinTargetManager7101);
	run receiver(child_AnonymousNewStdinTargetManager7101);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newReaderTarget107(Wgdef client_wg;Mutexdef client_mtx;Mutexdef client_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_cfg_ServiceDiscoveryConfig_StaticConfigscfg_ServiceDiscoveryConfig_StaticConfigs = -2; // opt var_cfg_ServiceDiscoveryConfig_StaticConfigscfg_ServiceDiscoveryConfig_StaticConfigs
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousNewStdinTargetManager710(Chandef app_called_ch;Wgdef client_wg;Mutexdef client_mtx;Mutexdef client_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Shutdown1031 = [1] of {int};
	run Shutdown103(app_called_ch,child_Shutdown1031);
	child_Shutdown1031?0;
	stop_process: skip;
	child!0
}
proctype Shutdown103(Chandef m_called_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: m_called_ch.enq!0;
	:: m_called_ch.sync!false -> 
		m_called_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype Stop93(Wgdef t_wg;Mutexdef t_mtx;Mutexdef t_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
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

