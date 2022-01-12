// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/cloudreve/Cloudreve/blob//pkg/filesystem/driver/upyun/handler.go#L167
#define def_var_routineNum183  ?? // mand routineNum line 183
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
	chan child_Delete1670 = [1] of {int};
	run Delete167(child_Delete1670);
	run receiver(child_Delete1670)
stop_process:skip
}

proctype Delete167(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousDelete1871800 = [1] of {int};
	Wgdef wg;
	Mutexdef failedLock;
	Mutexdef indexLock;
	int var_routineNum = def_var_routineNum183; // mand var_routineNum
	run mutexMonitor(indexLock);
	run mutexMonitor(failedLock);
	run wgMonitor(wg);
	wg.update!var_routineNum;
		for(i : 0.. var_routineNum-1) {
		for10: skip;
		run AnonymousDelete187180(wg,indexLock,failedLock,child_AnonymousDelete1871800);
		run receiver(child_AnonymousDelete1871800);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousDelete187180(Wgdef wg;Mutexdef indexLock;Mutexdef failedLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for11: skip;
		indexLock.Lock!false;
		

		if
		:: true -> 
			wg.update!-1;
			indexLock.Unlock!false;
			goto stop_process
		:: true;
		fi;
		indexLock.Unlock!false;
		

		if
		:: true -> 
			failedLock.Lock!false;
			failedLock.Unlock!false
		:: true;
		fi;
		for11_end: skip
	od;
	for11_exit: skip;
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

