#define not_found_{minCompressionLevel-1maxCompressionLevel+1}7024  -2
#define not_found_{minCompressionLevelmaxCompressionLevel}7524  -2

// https://github.com/gorilla/websocket/blob/master/compression_test.go#L68
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestValidCompressionLevel680 = [1] of {int};
	run TestValidCompressionLevel68(child_TestValidCompressionLevel680)
stop_process:skip
}

proctype TestValidCompressionLevel68(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetCompressionLevel11802 = [1] of {int};
	chan child_SetCompressionLevel11803 = [1] of {int};
	chan child_SetCompressionLevel11800 = [1] of {int};
	chan child_SetCompressionLevel11801 = [1] of {int};
	Mutexdef c_writeErrMu;
	run mutexMonitor(c_writeErrMu);
	

	if
	:: not_found_{minCompressionLevel-1maxCompressionLevel+1}7024-1 != -3 -> 
				for(i : 0.. not_found_{minCompressionLevel-1maxCompressionLevel+1}7024-1) {
			for10: skip;
			run SetCompressionLevel1180(c_writeErrMu,child_SetCompressionLevel11800);
			child_SetCompressionLevel11800?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run SetCompressionLevel1180(c_writeErrMu,child_SetCompressionLevel11801);
			child_SetCompressionLevel11801?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	

	if
	:: not_found_{minCompressionLevelmaxCompressionLevel}7524-1 != -3 -> 
				for(i : 0.. not_found_{minCompressionLevelmaxCompressionLevel}7524-1) {
			for20: skip;
			run SetCompressionLevel1180(c_writeErrMu,child_SetCompressionLevel11802);
			child_SetCompressionLevel11802?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			run SetCompressionLevel1180(c_writeErrMu,child_SetCompressionLevel11803);
			child_SetCompressionLevel11803?0;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype SetCompressionLevel1180(Mutexdef c_writeErrMu;chan child) {
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

