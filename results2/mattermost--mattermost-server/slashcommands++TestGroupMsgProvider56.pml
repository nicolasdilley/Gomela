// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/mattermost/mattermost-server/blob/5c16de58a02099df38e1e8486df148d1b798460a/app/slashcommands/command_groupmsg_test.go#L56
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
	chan child_TestGroupMsgProvider560 = [1] of {int};
	run TestGroupMsgProvider56(child_TestGroupMsgProvider560);
	run receiver(child_TestGroupMsgProvider560)
stop_process:skip
}

proctype TestGroupMsgProvider56(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_tearDown3870 = [1] of {int};
	chan child_addPermissionToRole4305 = [1] of {int};
	chan child_removePermissionFromRole3984 = [1] of {int};
	chan child_linkUserToTeam3473 = [1] of {int};
	chan child_createTeam1772 = [1] of {int};
	chan child_createUser1951 = [1] of {int};
	Mutexdef th_BasicPost_propsMu;
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
	run mutexMonitor(th_BasicPost_propsMu);
	run createUser195(th_BasicPost_propsMu,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_createUser1951);
	child_createUser1951?0;
	run createTeam177(th_BasicPost_propsMu,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_createTeam1772);
	child_createTeam1772?0;
	run linkUserToTeam347(th_BasicPost_propsMu,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_linkUserToTeam3473);
	child_linkUserToTeam3473?0;
	run removePermissionFromRole398(th_BasicPost_propsMu,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_removePermissionFromRole3984);
	child_removePermissionFromRole3984?0;
	run addPermissionToRole430(th_BasicPost_propsMu,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_addPermissionToRole4305);
	child_addPermissionToRole4305?0;
		defer1: skip;
	run tearDown387(th_BasicPost_propsMu,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_tearDown3870);
	child_tearDown3870?0;
	stop_process: skip;
	child!0
}
proctype tearDown387(Mutexdef th_BasicPost_propsMu;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_shutdownApp3710 = [1] of {int};
	run shutdownApp371(th_BasicPost_propsMu,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_shutdownApp3710);
	child_shutdownApp3710?0;
	stop_process: skip;
	child!0
}
proctype shutdownApp371(Mutexdef th_BasicPost_propsMu;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousshutdownApp3733720 = [1] of {int};
	Chandef done;
	run sync_monitor(done);
	run AnonymousshutdownApp373372(done,th_BasicPost_propsMu,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_AnonymousshutdownApp3733720);
	run receiver(child_AnonymousshutdownApp3733720);
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
proctype AnonymousshutdownApp373372(Chandef done;Mutexdef th_BasicPost_propsMu;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	done.closing!true;
	stop_process: skip;
	child!0
}
proctype createUser195(Mutexdef th_BasicPost_propsMu;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_createUserOrGuest2031 = [1] of {int};
	run createUserOrGuest203(th_BasicPost_propsMu,th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_createUserOrGuest2031);
	child_createUserOrGuest2031?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype createUserOrGuest203(Mutexdef th_BasicPost_propsMu;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype createTeam177(Mutexdef th_BasicPost_propsMu;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype linkUserToTeam347(Mutexdef th_BasicPost_propsMu;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype removePermissionFromRole398(Mutexdef th_BasicPost_propsMu;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int role_Permissions = -2; // opt role_Permissions
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype addPermissionToRole430(Mutexdef th_BasicPost_propsMu;Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int role_Permissions = -2; // opt role_Permissions
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

