
// https://github.com/valyala/fasthttp/blob/master/peripconn_test.go#L23
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPerIPConnCounter230 = [1] of {int};
	run TestPerIPConnCounter23(child_TestPerIPConnCounter230)
stop_process:skip
}

proctype TestPerIPConnCounter23(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Unregister267 = [1] of {int};
	chan child_Register156 = [1] of {int};
	chan child_Unregister265 = [1] of {int};
	chan child_Unregister264 = [1] of {int};
	chan child_Unregister263 = [1] of {int};
	chan child_Register152 = [1] of {int};
	chan child_Register151 = [1] of {int};
	chan child_Register150 = [1] of {int};
	Mutexdef cc_lock;
	run mutexMonitor(cc_lock);
	

	if
	:: 0 != -2 && 100-1 != -3 -> 
				for(i : 0.. 100-1) {
			for11: skip;
			run Register15(cc_lock,child_Register151);
			child_Register151?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Register15(cc_lock,child_Register150);
			child_Register150?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run Register15(cc_lock,child_Register152);
	child_Register152?0;
	

	if
	:: 0 != -2 && 100-1 != -3 -> 
				for(i : 0.. 100-1) {
			for21: skip;
			run Unregister26(cc_lock,child_Unregister264);
			child_Unregister264?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Unregister26(cc_lock,child_Unregister263);
			child_Unregister263?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	run Unregister26(cc_lock,child_Unregister265);
	child_Unregister265?0;
	run Register15(cc_lock,child_Register156);
	child_Register156?0;
	run Unregister26(cc_lock,child_Unregister267);
	child_Unregister267?0;
	stop_process: skip;
	child!0
}
proctype Register15(Mutexdef cc_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	cc_lock.Lock!false;
	cc_lock.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Unregister26(Mutexdef cc_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	cc_lock.Lock!false;
	

	if
	:: true -> 
		cc_lock.Unlock!false
	:: true;
	fi;
	

	if
	:: true -> 
		cc_lock.Unlock!false
	:: true;
	fi;
	cc_lock.Unlock!false;
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

