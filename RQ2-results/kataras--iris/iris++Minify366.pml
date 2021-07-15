
// https://github.com/kataras/iris/blob/master/iris.go#L366
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
	run Minify366(child_Minify3660)
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
	Mutexdef w_writer_pw_p_once_m;
	Mutexdef w_writer_pw_p_wrMu;
	run mutexMonitor(w_writer_pw_p_wrMu);
	run mutexMonitor(w_writer_pw_p_once_m);
	run wgMonitor(w_writer_wg);
	run mutexMonitor(w_m_mutex);
	run SetWriter184(w_writer_wg,w_writer_pw_p_wrMu,w_writer_pw_p_once_m,w_m_mutex,child_SetWriter1840);
	child_SetWriter1840?0;
	stop_process: skip;
	child!0
}
proctype SetWriter184(Wgdef underline_writer_wg;Mutexdef underline_writer_pw_p_wrMu;Mutexdef underline_writer_pw_p_once_m;Mutexdef underline_m_mutex;chan child) {
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

