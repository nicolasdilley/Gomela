// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/evanw/esbuild/blob/7d25497064e8a2a3f83c779dc29da2596bb60d0f/internal/graph/graph.go#L104
#define def_var_reachableFiles  ?? // mand reachableFiles line 106
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
	chan child_CloneLinkerGraph1040 = [1] of {int};
	run CloneLinkerGraph104(def_var_reachableFiles,child_CloneLinkerGraph1040);
	run receiver(child_CloneLinkerGraph1040)
stop_process:skip
}

proctype CloneLinkerGraph104(int var_reachableFiles;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousCloneLinkerGraph1271270 = [1] of {int};
	Wgdef waitGroup;
	Mutexdef dynamicImportEntryPointsMutex;
	int var_dynamicImportEntryPoints = -2; // opt var_dynamicImportEntryPoints
	int var_entryPoints = -2; // opt var_entryPoints
	run mutexMonitor(dynamicImportEntryPointsMutex);
	run wgMonitor(waitGroup);
	waitGroup.update!var_reachableFiles;
		for(i : 0.. var_reachableFiles-1) {
		for20: skip;
		run AnonymousCloneLinkerGraph127127(waitGroup,dynamicImportEntryPointsMutex,child_AnonymousCloneLinkerGraph1271270);
		run receiver(child_AnonymousCloneLinkerGraph1271270);
		for20_end: skip
	};
	for20_exit: skip;
	waitGroup.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousCloneLinkerGraph127127(Wgdef waitGroup;Mutexdef dynamicImportEntryPointsMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_repr_AST_TopLevelSymbolToParts = -2; // opt var_repr_AST_TopLevelSymbolToParts
	int var_repr_AST_NamedExports = -2; // opt var_repr_AST_NamedExports
	int var_repr_AST_NamedImports = -2; // opt var_repr_AST_NamedImports
	int var_repr_AST_ImportRecords = -2; // opt var_repr_AST_ImportRecords
	int var_part_SymbolUses = -2; // opt var_part_SymbolUses
	int var_repr_AST_Parts = -2; // opt var_repr_AST_Parts
	

	if
	:: true;
	:: true;
	fi;
	waitGroup.update!-1;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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

