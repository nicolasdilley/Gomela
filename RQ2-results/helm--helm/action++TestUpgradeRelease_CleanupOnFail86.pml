#define not_found_197  -2
#define not_found_328  -2

// https://github.com/helm/helm/blob/master/pkg/action/upgrade_test.go#L86
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUpgradeRelease_CleanupOnFail860 = [1] of {int};
	run TestUpgradeRelease_CleanupOnFail86(child_TestUpgradeRelease_CleanupOnFail860)
stop_process:skip
}

proctype TestUpgradeRelease_CleanupOnFail86(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Run1110 = [1] of {int};
	Mutexdef upAction_cfg_RegistryClient_cache_memoryStore_lock;
	run mutexMonitor(upAction_cfg_RegistryClient_cache_memoryStore_lock);
	run Run111(upAction_cfg_RegistryClient_cache_memoryStore_lock,child_Run1110);
	child_Run1110?0;
	stop_process: skip;
	child!0
}
proctype Run111(Mutexdef u_cfg_RegistryClient_cache_memoryStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_performUpgrade2441 = [1] of {int};
	chan child_prepareUpgrade1480 = [1] of {int};
	

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
	run prepareUpgrade148(u_cfg_RegistryClient_cache_memoryStore_lock,child_prepareUpgrade1480);
	child_prepareUpgrade1480?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run performUpgrade244(u_cfg_RegistryClient_cache_memoryStore_lock,child_performUpgrade2441);
	child_performUpgrade2441?0;
	

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
proctype prepareUpgrade148(Mutexdef u_cfg_RegistryClient_cache_memoryStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_renderResources1052 = [1] of {int};
	chan child_getCapabilities2391 = [1] of {int};
	chan child_reuseValues4340 = [1] of {int};
	

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
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			fi
		:: true;
		fi
	fi;
	run reuseValues434(u_cfg_RegistryClient_cache_memoryStore_lock,child_reuseValues4340);
	child_reuseValues4340?0;
	

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
	run getCapabilities239(u_cfg_RegistryClient_cache_memoryStore_lock,child_getCapabilities2391);
	child_getCapabilities2391?0;
	

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
	run renderResources105(u_cfg_RegistryClient_cache_memoryStore_lock,child_renderResources1052);
	child_renderResources1052?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype reuseValues434(Mutexdef u_cfg_RegistryClient_cache_memoryStore_lock;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getCapabilities239(Mutexdef c_RegistryClient_cache_memoryStore_lock;chan child) {
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
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype renderResources105(Mutexdef c_RegistryClient_cache_memoryStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getCapabilities2392 = [1] of {int};
	run getCapabilities239(c_RegistryClient_cache_memoryStore_lock,child_getCapabilities2392);
	child_getCapabilities2392?0;
	

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
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
proctype performUpgrade244(Mutexdef u_cfg_RegistryClient_cache_memoryStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_recordRelease35812 = [1] of {int};
	chan child_failRelease36711 = [1] of {int};
	chan child_execHook3010 = [1] of {int};
	chan child_failRelease3677 = [1] of {int};
	chan child_recordRelease3586 = [1] of {int};
	chan child_failRelease3679 = [1] of {int};
	chan child_recordRelease3588 = [1] of {int};
	chan child_recreate4735 = [1] of {int};
	chan child_failRelease3674 = [1] of {int};
	chan child_recordRelease3583 = [1] of {int};
	chan child_failRelease3672 = [1] of {int};
	chan child_execHook301 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run execHook30(u_cfg_RegistryClient_cache_memoryStore_lock,child_execHook301);
		child_execHook301?0;
		

		if
		:: true -> 
			run failRelease367(u_cfg_RegistryClient_cache_memoryStore_lock,child_failRelease3672);
			child_failRelease3672?0;
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		run recordRelease358(u_cfg_RegistryClient_cache_memoryStore_lock,child_recordRelease3583);
		child_recordRelease3583?0;
		run failRelease367(u_cfg_RegistryClient_cache_memoryStore_lock,child_failRelease3674);
		child_failRelease3674?0;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run recreate473(u_cfg_RegistryClient_cache_memoryStore_lock,not_found_328,child_recreate4735);
		child_recreate4735?0
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				run recordRelease358(u_cfg_RegistryClient_cache_memoryStore_lock,child_recordRelease3586);
				child_recordRelease3586?0;
				run failRelease367(u_cfg_RegistryClient_cache_memoryStore_lock,child_failRelease3677);
				child_failRelease3677?0;
				goto stop_process
			:: true;
			fi
		:: true -> 
			

			if
			:: true -> 
				run recordRelease358(u_cfg_RegistryClient_cache_memoryStore_lock,child_recordRelease3588);
				child_recordRelease3588?0;
				run failRelease367(u_cfg_RegistryClient_cache_memoryStore_lock,child_failRelease3679);
				child_failRelease3679?0;
				goto stop_process
			:: true;
			fi
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		run execHook30(u_cfg_RegistryClient_cache_memoryStore_lock,child_execHook3010);
		child_execHook3010?0;
		

		if
		:: true -> 
			run failRelease367(u_cfg_RegistryClient_cache_memoryStore_lock,child_failRelease36711);
			child_failRelease36711?0;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run recordRelease358(u_cfg_RegistryClient_cache_memoryStore_lock,child_recordRelease35812);
	child_recordRelease35812?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype execHook30(Mutexdef cfg_RegistryClient_cache_memoryStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_deleteHookByPolicy1237 = [1] of {int};
	chan child_deleteHookByPolicy1238 = [1] of {int};
	chan child_deleteHookByPolicy1233 = [1] of {int};
	chan child_recordRelease3582 = [1] of {int};
	chan child_deleteHookByPolicy1231 = [1] of {int};
	chan child_deleteHookByPolicy1236 = [1] of {int};
	chan child_recordRelease3585 = [1] of {int};
	chan child_deleteHookByPolicy1234 = [1] of {int};
	int executingHooks = -2;
	

	if
	:: executingHooks-1 != -3 -> 
				for(i : 0.. executingHooks-1) {
			for80: skip;
			run deleteHookByPolicy123(cfg_RegistryClient_cache_memoryStore_lock,child_deleteHookByPolicy1231);
			child_deleteHookByPolicy1231?0;
			

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
			run recordRelease358(cfg_RegistryClient_cache_memoryStore_lock,child_recordRelease3582);
			child_recordRelease3582?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				run deleteHookByPolicy123(cfg_RegistryClient_cache_memoryStore_lock,child_deleteHookByPolicy1233);
				child_deleteHookByPolicy1233?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto stop_process
			:: true;
			fi;
			for80_end: skip
		};
		for80_exit: skip
	:: else -> 
		do
		:: true -> 
			for81: skip;
			run deleteHookByPolicy123(cfg_RegistryClient_cache_memoryStore_lock,child_deleteHookByPolicy1234);
			child_deleteHookByPolicy1234?0;
			

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
			run recordRelease358(cfg_RegistryClient_cache_memoryStore_lock,child_recordRelease3585);
			child_recordRelease3585?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				run deleteHookByPolicy123(cfg_RegistryClient_cache_memoryStore_lock,child_deleteHookByPolicy1236);
				child_deleteHookByPolicy1236?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto stop_process
			:: true;
			fi;
			for81_end: skip
		:: true -> 
			break
		od;
		for81_exit: skip
	fi;
	

	if
	:: executingHooks-1 != -3 -> 
				for(i : 0.. executingHooks-1) {
			for90: skip;
			run deleteHookByPolicy123(cfg_RegistryClient_cache_memoryStore_lock,child_deleteHookByPolicy1237);
			child_deleteHookByPolicy1237?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for90_end: skip
		};
		for90_exit: skip
	:: else -> 
		do
		:: true -> 
			for91: skip;
			run deleteHookByPolicy123(cfg_RegistryClient_cache_memoryStore_lock,child_deleteHookByPolicy1238);
			child_deleteHookByPolicy1238?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for91_end: skip
		:: true -> 
			break
		od;
		for91_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype deleteHookByPolicy123(Mutexdef cfg_RegistryClient_cache_memoryStore_lock;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

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
proctype recordRelease358(Mutexdef c_RegistryClient_cache_memoryStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype failRelease367(Mutexdef u_cfg_RegistryClient_cache_memoryStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Run586 = [1] of {int};
	chan child_NewRollback515 = [1] of {int};
	Mutexdef rollin_cfg_RegistryClient_cache_memoryStore_lock;
	chan child_Run474 = [1] of {int};
	chan child_NewHistory403 = [1] of {int};
	Mutexdef hist_cfg_RegistryClient_cache_memoryStore_lock;
	chan child_recordRelease3582 = [1] of {int};
	run recordRelease358(u_cfg_RegistryClient_cache_memoryStore_lock,child_recordRelease3582);
	child_recordRelease3582?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		run mutexMonitor(hist_cfg_RegistryClient_cache_memoryStore_lock);
		run NewHistory40(u_cfg_RegistryClient_cache_memoryStore_lock,child_NewHistory403);
		child_NewHistory403?0;
		run Run47(hist_cfg_RegistryClient_cache_memoryStore_lock,child_Run474);
		child_Run474?0;
		

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
		run mutexMonitor(rollin_cfg_RegistryClient_cache_memoryStore_lock);
		run NewRollback51(u_cfg_RegistryClient_cache_memoryStore_lock,child_NewRollback515);
		child_NewRollback515?0;
		run Run58(rollin_cfg_RegistryClient_cache_memoryStore_lock,child_Run586);
		child_Run586?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewHistory40(Mutexdef cfg_RegistryClient_cache_memoryStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Run47(Mutexdef h_cfg_RegistryClient_cache_memoryStore_lock;chan child) {
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
proctype NewRollback51(Mutexdef cfg_RegistryClient_cache_memoryStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Run58(Mutexdef r_cfg_RegistryClient_cache_memoryStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_performRollback1437 = [1] of {int};
	chan child_prepareRollback946 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run prepareRollback94(r_cfg_RegistryClient_cache_memoryStore_lock,child_prepareRollback946);
	child_prepareRollback946?0;
	

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
	run performRollback143(r_cfg_RegistryClient_cache_memoryStore_lock,child_performRollback1437);
	child_performRollback1437?0;
	

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
proctype prepareRollback94(Mutexdef r_cfg_RegistryClient_cache_memoryStore_lock;chan child) {
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
proctype performRollback143(Mutexdef r_cfg_RegistryClient_cache_memoryStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_recordRelease35816 = [1] of {int};
	chan child_recordRelease35817 = [1] of {int};
	chan child_execHook3015 = [1] of {int};
	chan child_recordRelease35812 = [1] of {int};
	chan child_recordRelease35811 = [1] of {int};
	chan child_recordRelease35814 = [1] of {int};
	chan child_recordRelease35813 = [1] of {int};
	chan child_recreate47310 = [1] of {int};
	chan child_recordRelease3589 = [1] of {int};
	chan child_recordRelease3588 = [1] of {int};
	chan child_execHook307 = [1] of {int};
	int deployed = -2;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run execHook30(r_cfg_RegistryClient_cache_memoryStore_lock,child_execHook307);
		child_execHook307?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		run recordRelease358(r_cfg_RegistryClient_cache_memoryStore_lock,child_recordRelease3588);
		child_recordRelease3588?0;
		run recordRelease358(r_cfg_RegistryClient_cache_memoryStore_lock,child_recordRelease3589);
		child_recordRelease3589?0;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run recreate473(r_cfg_RegistryClient_cache_memoryStore_lock,not_found_197,child_recreate47310);
		child_recreate47310?0
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				run recordRelease358(r_cfg_RegistryClient_cache_memoryStore_lock,child_recordRelease35811);
				child_recordRelease35811?0;
				run recordRelease358(r_cfg_RegistryClient_cache_memoryStore_lock,child_recordRelease35812);
				child_recordRelease35812?0;
				goto stop_process
			:: true;
			fi
		:: true -> 
			

			if
			:: true -> 
				run recordRelease358(r_cfg_RegistryClient_cache_memoryStore_lock,child_recordRelease35813);
				child_recordRelease35813?0;
				run recordRelease358(r_cfg_RegistryClient_cache_memoryStore_lock,child_recordRelease35814);
				child_recordRelease35814?0;
				goto stop_process
			:: true;
			fi
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		run execHook30(r_cfg_RegistryClient_cache_memoryStore_lock,child_execHook3015);
		child_execHook3015?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: deployed-1 != -3 -> 
				for(i : 0.. deployed-1) {
			for130: skip;
			run recordRelease358(r_cfg_RegistryClient_cache_memoryStore_lock,child_recordRelease35816);
			child_recordRelease35816?0;
			for130_end: skip
		};
		for130_exit: skip
	:: else -> 
		do
		:: true -> 
			for131: skip;
			run recordRelease358(r_cfg_RegistryClient_cache_memoryStore_lock,child_recordRelease35817);
			child_recordRelease35817?0;
			for131_end: skip
		:: true -> 
			break
		od;
		for131_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype recreate473(Mutexdef cfg_RegistryClient_cache_memoryStore_lock;int resources;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_KubernetesClientSet28010 = [1] of {int};
	chan child_KubernetesClientSet28011 = [1] of {int};
	

	if
	:: resources-1 != -3 -> 
				for(i : 0.. resources-1) {
			for120: skip;
			

			if
			:: true -> 
				goto for120_end
			:: true;
			fi;
			run KubernetesClientSet280(cfg_RegistryClient_cache_memoryStore_lock,child_KubernetesClientSet28010);
			child_KubernetesClientSet28010?0;
			

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
			for120_end: skip
		};
		for120_exit: skip
	:: else -> 
		do
		:: true -> 
			for123: skip;
			

			if
			:: true -> 
				goto for123_end
			:: true;
			fi;
			run KubernetesClientSet280(cfg_RegistryClient_cache_memoryStore_lock,child_KubernetesClientSet28011);
			child_KubernetesClientSet28011?0;
			

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
			for123_end: skip
		:: true -> 
			break
		od;
		for123_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype KubernetesClientSet280(Mutexdef c_RegistryClient_cache_memoryStore_lock;chan child) {
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

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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

