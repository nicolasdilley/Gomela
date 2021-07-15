
// https://github.com/mattermost/mattermost-server/blob/master/store/storetest/reaction_store.go#L647
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
	chan child_testReactionDeadlock6470 = [1] of {int};
	run testReactionDeadlock647(child_testReactionDeadlock6470)
stop_process:skip
}

proctype testReactionDeadlock647(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoustestReactionDeadlock7016911 = [1] of {int};
	chan child_AnonymoustestReactionDeadlock6946910 = [1] of {int};
	Wgdef wg;
	Mutexdef post_propsMu;
	run mutexMonitor(post_propsMu);
	run wgMonitor(wg);
	wg.update!2;
	run AnonymoustestReactionDeadlock694691(wg,post_propsMu,child_AnonymoustestReactionDeadlock6946910);
	run AnonymoustestReactionDeadlock701691(wg,post_propsMu,child_AnonymoustestReactionDeadlock7016911);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymoustestReactionDeadlock694691(Wgdef wg;Mutexdef post_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype AnonymoustestReactionDeadlock701691(Wgdef wg;Mutexdef post_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		wg.update!-1;
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

