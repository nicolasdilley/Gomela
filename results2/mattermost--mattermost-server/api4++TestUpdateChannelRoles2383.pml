// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/mattermost/mattermost-server/blob/5c16de58a02099df38e1e8486df148d1b798460a/api4/channel_test.go#L2383
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
	chan child_TestUpdateChannelRoles23830 = [1] of {int};
	run TestUpdateChannelRoles2383(child_TestUpdateChannelRoles23830);
	run receiver(child_TestUpdateChannelRoles23830)
stop_process:skip
}

proctype TestUpdateChannelRoles2383(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TearDown2920 = [1] of {int};
	chan child_LoginBasic7054 = [1] of {int};
	chan child_LoginBasic7053 = [1] of {int};
	chan child_LoginBasic27092 = [1] of {int};
	chan child_CreatePublicChannel5861 = [1] of {int};
	Mutexdef th_BasicPost_propsMu;
	Mutexdef th_ConfigStore_configLock;
	Mutexdef th_Server_featureFlagSynchronizerMutex;
	Mutexdef th_Server_uploadLockMapMut;
	Mutexdef th_Server_pluginCommandsLock;
	Mutexdef th_Server_PluginsLock;
	Mutexdef th_Server_metricsLock;
	run mutexMonitor(th_Server_metricsLock);
	run mutexMonitor(th_Server_PluginsLock);
	run mutexMonitor(th_Server_pluginCommandsLock);
	run mutexMonitor(th_Server_uploadLockMapMut);
	run mutexMonitor(th_Server_featureFlagSynchronizerMutex);
	run mutexMonitor(th_ConfigStore_configLock);
	run mutexMonitor(th_BasicPost_propsMu);
	run CreatePublicChannel586(th_BasicPost_propsMu,th_ConfigStore_configLock,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_CreatePublicChannel5861);
	child_CreatePublicChannel5861?0;
	run LoginBasic2709(th_BasicPost_propsMu,th_ConfigStore_configLock,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_LoginBasic27092);
	child_LoginBasic27092?0;
	run LoginBasic705(th_BasicPost_propsMu,th_ConfigStore_configLock,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_LoginBasic7053);
	child_LoginBasic7053?0;
	run LoginBasic705(th_BasicPost_propsMu,th_ConfigStore_configLock,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_LoginBasic7054);
	child_LoginBasic7054?0;
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
	Chandef done;
	run sync_monitor(done);
	run AnonymousShutdownApp278277(done,th_BasicPost_propsMu,th_ConfigStore_configLock,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_AnonymousShutdownApp2782770);
	run receiver(child_AnonymousShutdownApp2782770);
	do
	:: done.deq?state,num_msgs -> 
		break
	:: done.sync?state -> 
		done.rcving!false;
		break
	:: true -> 
		break
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousShutdownApp278277(Chandef done;Mutexdef th_BasicPost_propsMu;Mutexdef th_ConfigStore_configLock;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	done.closing!true;
	stop_process: skip;
	child!0
}
proctype CreatePublicChannel586(Mutexdef th_BasicPost_propsMu;Mutexdef th_ConfigStore_configLock;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CreateChannelWithClient5941 = [1] of {int};
	run CreateChannelWithClient594(th_BasicPost_propsMu,th_ConfigStore_configLock,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_CreateChannelWithClient5941);
	child_CreateChannelWithClient5941?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype CreateChannelWithClient594(Mutexdef th_BasicPost_propsMu;Mutexdef th_ConfigStore_configLock;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CreateChannelWithClientAndTeam5981 = [1] of {int};
	run CreateChannelWithClientAndTeam598(th_BasicPost_propsMu,th_ConfigStore_configLock,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_CreateChannelWithClientAndTeam5981);
	child_CreateChannelWithClientAndTeam5981?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype CreateChannelWithClientAndTeam598(Mutexdef th_BasicPost_propsMu;Mutexdef th_ConfigStore_configLock;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype LoginBasic2709(Mutexdef th_BasicPost_propsMu;Mutexdef th_ConfigStore_configLock;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_LoginBasic2WithClient7342 = [1] of {int};
	run LoginBasic2WithClient734(th_BasicPost_propsMu,th_ConfigStore_configLock,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_LoginBasic2WithClient7342);
	child_LoginBasic2WithClient7342?0;
	stop_process: skip;
	child!0
}
proctype LoginBasic2WithClient734(Mutexdef th_BasicPost_propsMu;Mutexdef th_ConfigStore_configLock;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype LoginBasic705(Mutexdef th_BasicPost_propsMu;Mutexdef th_ConfigStore_configLock;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_LoginBasicWithClient7253 = [1] of {int};
	run LoginBasicWithClient725(th_BasicPost_propsMu,th_ConfigStore_configLock,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_LoginBasicWithClient7253);
	child_LoginBasicWithClient7253?0;
	stop_process: skip;
	child!0
}
proctype LoginBasicWithClient725(Mutexdef th_BasicPost_propsMu;Mutexdef th_ConfigStore_configLock;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
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

