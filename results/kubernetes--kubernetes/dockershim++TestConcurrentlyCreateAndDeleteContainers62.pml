#define TestConcurrentlyCreateAndDeleteContainers_configs  1

// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/dockershim/docker_container_test.go#L62
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
	chan child_TestConcurrentlyCreateAndDeleteContainers620 = [1] of {int};
	run TestConcurrentlyCreateAndDeleteContainers62(child_TestConcurrentlyCreateAndDeleteContainers620)
stop_process:skip
}

proctype TestConcurrentlyCreateAndDeleteContainers62(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestConcurrentlyCreateAndDeleteContainers1101103 = [1] of {int};
	chan child_AnonymousTestConcurrentlyCreateAndDeleteContainers94941 = [1] of {int};
	chan child_AnonymousTestConcurrentlyCreateAndDeleteContainers89800 = [1] of {int};
	Wgdef deletionWg;
	Wgdef creationWg;
	Chandef containerIDs;
	Mutexdef ds_cleanupInfosLock;
	Mutexdef ds_networkReadyLock;
	Mutexdef ds_network_podsLock;
	int configs = TestConcurrentlyCreateAndDeleteContainers_configs;
	run mutexMonitor(ds_network_podsLock);
	run mutexMonitor(ds_networkReadyLock);
	run mutexMonitor(ds_cleanupInfosLock);
	

	if
	:: configs > 0 -> 
		containerIDs.size = configs;
		run AsyncChan(containerIDs)
	:: else -> 
		run sync_monitor(containerIDs)
	fi;
	run wgMonitor(creationWg);
	run wgMonitor(deletionWg);
	creationWg.update!configs;
	run AnonymousTestConcurrentlyCreateAndDeleteContainers8980(containerIDs,creationWg,deletionWg,ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_AnonymousTestConcurrentlyCreateAndDeleteContainers89800);
		for(i : 0.. configs-1) {
		for20: skip;
		run AnonymousTestConcurrentlyCreateAndDeleteContainers9494(containerIDs,creationWg,deletionWg,ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_AnonymousTestConcurrentlyCreateAndDeleteContainers94941);
		for20_end: skip
	};
	for20_exit: skip;
	do
	:: true -> 
		

		if
		:: containerIDs.deq?state,num_msgs;
		:: containerIDs.sync?state -> 
			containerIDs.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for30: skip;
			deletionWg.update!1;
			run AnonymousTestConcurrentlyCreateAndDeleteContainers110110(containerIDs,creationWg,deletionWg,ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_AnonymousTestConcurrentlyCreateAndDeleteContainers1101103);
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	deletionWg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestConcurrentlyCreateAndDeleteContainers8980(Chandef containerIDs;Wgdef creationWg;Wgdef deletionWg;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	creationWg.wait?0;
	containerIDs.closing!true;
	stop_process: skip;
	child!0
}
proctype AnonymousTestConcurrentlyCreateAndDeleteContainers9494(Chandef containerIDs;Wgdef creationWg;Wgdef deletionWg;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CreateContainer1091 = [1] of {int};
	run CreateContainer109(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_CreateContainer1091);
	child_CreateContainer1091?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: containerIDs.enq!0;
	:: containerIDs.sync!false -> 
		containerIDs.sending!false
	fi;
	stop_process: skip;
		creationWg.update!-1;
	child!0
}
proctype CreateContainer109(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_performPlatformSpecificContainerCleanupAndLogErrors4966 = [1] of {int};
	chan child_setContainerCleanupInfo935 = [1] of {int};
	chan child_applyPlatformSpecificDockerConfig314 = [1] of {int};
	chan child_getSecurityOpts353 = [1] of {int};
	chan child_updateCreateConfig452 = [1] of {int};
	chan child_getDockerAPIVersion5051 = [1] of {int};
	

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
	run getDockerAPIVersion505(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getDockerAPIVersion5051);
	child_getDockerAPIVersion5051?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run updateCreateConfig45(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_updateCreateConfig452);
	child_updateCreateConfig452?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getSecurityOpts35(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getSecurityOpts353);
	child_getSecurityOpts353?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run applyPlatformSpecificDockerConfig31(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_applyPlatformSpecificDockerConfig314);
	child_applyPlatformSpecificDockerConfig314?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run setContainerCleanupInfo93(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_setContainerCleanupInfo935);
			child_setContainerCleanupInfo935?0
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	run performPlatformSpecificContainerCleanupAndLogErrors496(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_performPlatformSpecificContainerCleanupAndLogErrors4966);
	child_performPlatformSpecificContainerCleanupAndLogErrors4966?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getDockerAPIVersion505(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getDockerVersionFromCache5241 = [1] of {int};
	chan child_getDockerVersion3412 = [1] of {int};
	

	if
	:: true -> 
		run getDockerVersionFromCache524(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getDockerVersionFromCache5241);
		child_getDockerVersionFromCache5241?0
	:: true -> 
		run getDockerVersion341(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getDockerVersion3412);
		child_getDockerVersion3412?0
	fi;
	

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
proctype getDockerVersionFromCache524(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
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
proctype getDockerVersion341(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype updateCreateConfig45(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getSecurityOpts35(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype applyPlatformSpecificDockerConfig31(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype setContainerCleanupInfo93(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ds_cleanupInfosLock.Lock!false;
	stop_process: skip;
		ds_cleanupInfosLock.Unlock!false;
	child!0
}
proctype performPlatformSpecificContainerCleanupAndLogErrors496(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_performPlatformSpecificContainerCleanup376 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run performPlatformSpecificContainerCleanup37(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_performPlatformSpecificContainerCleanup376);
	child_performPlatformSpecificContainerCleanup376?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype performPlatformSpecificContainerCleanup37(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTestConcurrentlyCreateAndDeleteContainers110110(Chandef containerIDs;Wgdef creationWg;Wgdef deletionWg;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RemoveContainer3163 = [1] of {int};
	run RemoveContainer316(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_RemoveContainer3163);
	child_RemoveContainer3163?0;
	stop_process: skip;
		deletionWg.update!-1;
	child!0
}
proctype RemoveContainer316(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_performPlatformSpecificContainerForContainer4844 = [1] of {int};
	chan child_removeContainerLogSymlink2703 = [1] of {int};
	run removeContainerLogSymlink270(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_removeContainerLogSymlink2703);
	child_removeContainerLogSymlink2703?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run performPlatformSpecificContainerForContainer484(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_performPlatformSpecificContainerForContainer4844);
	child_performPlatformSpecificContainerForContainer4844?0;
	

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
proctype removeContainerLogSymlink270(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getContainerLogPath2223 = [1] of {int};
	run getContainerLogPath222(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getContainerLogPath2223);
	child_getContainerLogPath2223?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getContainerLogPath222(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype performPlatformSpecificContainerForContainer484(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_clearContainerCleanupInfo996 = [1] of {int};
	chan child_performPlatformSpecificContainerCleanupAndLogErrors4965 = [1] of {int};
	chan child_getContainerCleanupInfo864 = [1] of {int};
	run getContainerCleanupInfo86(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getContainerCleanupInfo864);
	child_getContainerCleanupInfo864?0;
	

	if
	:: true -> 
		run performPlatformSpecificContainerCleanupAndLogErrors496(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_performPlatformSpecificContainerCleanupAndLogErrors4965);
		child_performPlatformSpecificContainerCleanupAndLogErrors4965?0;
		

		if
		:: true -> 
			run clearContainerCleanupInfo99(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_clearContainerCleanupInfo996);
			child_clearContainerCleanupInfo996?0
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getContainerCleanupInfo86(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ds_cleanupInfosLock.RLock!false;
	goto stop_process;
	stop_process: skip;
		ds_cleanupInfosLock.RUnlock!false;
	child!0
}
proctype clearContainerCleanupInfo99(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ds_cleanupInfosLock.Lock!false;
	stop_process: skip;
		ds_cleanupInfosLock.Unlock!false;
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

