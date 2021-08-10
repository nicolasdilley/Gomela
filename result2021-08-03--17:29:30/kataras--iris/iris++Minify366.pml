// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kataras/iris/blob/fa175eb84754a45baecc4cd0044249fad05dfe1e/iris.go#L366
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
	chan child_Minify3660 = [1] of {int};
	run Minify366(child_Minify3660);
	run receiver(child_Minify3660)
stop_process:skip
}

proctype Minify366(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetWriter1840 = [1] of {int};
	Mutexdef w_m_mutex;
	Wgdef w_writer_wg;
	run wgMonitor(w_writer_wg);
	run mutexMonitor(w_m_mutex);
	run SetWriter184(w_writer_wg,w_m_mutex,child_SetWriter1840);
	child_SetWriter1840?0;
	stop_process: skip;
	child!0
}
proctype SetWriter184(Wgdef underline_writer_wg;Mutexdef underline_m_mutex;chan child) {
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

