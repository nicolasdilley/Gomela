// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/collection/safemap_test.go#L31
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSafeMap_CopyNew310 = [1] of {int};
	run TestSafeMap_CopyNew31(child_TestSafeMap_CopyNew310);
	run receiver(child_TestSafeMap_CopyNew310)
stop_process:skip
}

proctype TestSafeMap_CopyNew31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get5911 = [1] of {int};
	chan child_Get5910 = [1] of {int};
	chan child_Get599 = [1] of {int};
	chan child_Get598 = [1] of {int};
	chan child_Del307 = [1] of {int};
	chan child_Del306 = [1] of {int};
	chan child_Set725 = [1] of {int};
	chan child_Set724 = [1] of {int};
	chan child_Del303 = [1] of {int};
	chan child_Del302 = [1] of {int};
	chan child_Set721 = [1] of {int};
	chan child_Set720 = [1] of {int};
	Mutexdef m_lock;
	run mutexMonitor(m_lock);
	

	if
	:: 0 != -2 && 100000-1 != -3 -> 
				for(i : 0.. 100000-1) {
			for11: skip;
			run Set72(m_lock,child_Set721);
			child_Set721?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Set72(m_lock,child_Set720);
			child_Set720?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: 0 != -2 && 100000-1 != -3 -> 
				for(i : 0.. 100000-1) {
			for25: skip;
			

			if
			:: true -> 
				run Del30(m_lock,child_Del303);
				child_Del303?0
			:: true;
			fi;
			for25_end: skip
		};
		for25_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: true -> 
				run Del30(m_lock,child_Del302);
				child_Del302?0
			:: true;
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	

	if
	:: 0 != -2 && 100000<<1-1 != -3 -> 
				for(i : 0.. 100000<<1-1) {
			for31: skip;
			run Set72(m_lock,child_Set725);
			child_Set725?0;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			run Set72(m_lock,child_Set724);
			child_Set724?0;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	

	if
	:: 0 != -2 && 100000<<1-1 != -3 -> 
				for(i : 0.. 100000<<1-1) {
			for41: skip;
			

			if
			:: true -> 
				run Del30(m_lock,child_Del307);
				child_Del307?0
			:: true;
			fi;
			for41_end: skip
		};
		for41_exit: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			

			if
			:: true -> 
				run Del30(m_lock,child_Del306);
				child_Del306?0
			:: true;
			fi;
			for40_end: skip
		:: true -> 
			break
		od;
		for40_exit: skip
	fi;
	

	if
	:: 0 != -2 && 100000-1 != -3 -> 
				for(i : 0.. 100000-1) {
			for51: skip;
			run Get59(m_lock,child_Get599);
			child_Get599?0;
			for51_end: skip
		};
		for51_exit: skip
	:: else -> 
		do
		:: true -> 
			for50: skip;
			run Get59(m_lock,child_Get598);
			child_Get598?0;
			for50_end: skip
		:: true -> 
			break
		od;
		for50_exit: skip
	fi;
	

	if
	:: 0 != -2 && 100000<<1-1 != -3 -> 
				for(i : 0.. 100000<<1-1) {
			for61: skip;
			run Get59(m_lock,child_Get5911);
			child_Get5911?0;
			for61_end: skip
		};
		for61_exit: skip
	:: else -> 
		do
		:: true -> 
			for60: skip;
			run Get59(m_lock,child_Get5910);
			child_Get5910?0;
			for60_end: skip
		:: true -> 
			break
		od;
		for60_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Set72(Mutexdef m_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_lock.Lock!false;
	m_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Del30(Mutexdef m_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_m_dirtyNew = -2; // opt var_m_dirtyNew
	int var_m_dirtyOld = -2; // opt var_m_dirtyOld
	m_lock.Lock!false;
	m_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Get59(Mutexdef m_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_lock.RLock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	m_lock.RUnlock!false;
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

proctype receiver(chan c) {
c?0
}

