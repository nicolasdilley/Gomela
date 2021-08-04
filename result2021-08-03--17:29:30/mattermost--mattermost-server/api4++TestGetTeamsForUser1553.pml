// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/mattermost/mattermost-server/blob/5c16de58a02099df38e1e8486df148d1b798460a/api4/team_test.go#L1553
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
	chan child_TestGetTeamsForUser15530 = [1] of {int};
	run TestGetTeamsForUser1553(child_TestGetTeamsForUser15530);
	run receiver(child_TestGetTeamsForUser15530)
stop_process:skip
}

proctype TestGetTeamsForUser1553(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TearDown2920 = [1] of {int};
	Mutexdef th_BasicPost_propsMu;
	Mutexdef th_ConfigStore_configLock;
	Mutexdef th_Server_featureFlagSynchronizerMutex;
	Mutexdef th_Server_uploadLockMapMut;
	Mutexdef th_Server_pluginCommandsLock;
	Mutexdef th_Server_PluginsLock;
	Mutexdef th_Server_metricsLock;
	int var_teams = -2; // opt var_teams
	run mutexMonitor(th_Server_metricsLock);
	run mutexMonitor(th_Server_PluginsLock);
	run mutexMonitor(th_Server_pluginCommandsLock);
	run mutexMonitor(th_Server_uploadLockMapMut);
	run mutexMonitor(th_Server_featureFlagSynchronizerMutex);
	run mutexMonitor(th_ConfigStore_configLock);
	run mutexMonitor(th_BasicPost_propsMu);
		defer1: skip;
	run TearDown292(th_BasicPost_propsMu,th_ConfigStore_configLock,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_TearDown2920);
	child_TearDown2920?0;
	stop_process: skip;
	child!0
}
proctype TearDown292(Mutexdef th_BasicPost_propsMu;Mutexdef th_ConfigStore_configLock;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ShutdownApp2760 = [1] of {int};
	run ShutdownApp276(th_BasicPost_propsMu,th_ConfigStore_configLock,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_ShutdownApp2760);
	child_ShutdownApp2760?0;
	stop_process: skip;
	child!0
}
proctype ShutdownApp276(Mutexdef th_BasicPost_propsMu;Mutexdef th_ConfigStore_configLock;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousShutdownApp2782770 = [1] of {int};
	Chandef done_ch;
	run sync_monitor(done_ch);
	run AnonymousShutdownApp278277(done_ch,th_BasicPost_propsMu,th_ConfigStore_configLock,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_AnonymousShutdownApp2782770);
	run receiver(child_AnonymousShutdownApp2782770);
	do
	:: done_ch.deq?state,num_msgs -> 
		break
	:: done_ch.sync?state -> 
		done_ch.rcving!false;
		break
	:: true -> 
		break
	od;
	for10_exit: skip;
	for10_end: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousShutdownApp278277(Chandef done_ch;Mutexdef th_BasicPost_propsMu;Mutexdef th_ConfigStore_configLock;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	done_ch.closing!true;
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

