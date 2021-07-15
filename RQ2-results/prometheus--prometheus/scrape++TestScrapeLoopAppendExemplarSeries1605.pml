
// https://github.com/prometheus/prometheus/blob/master/scrape/scrape_test.go#L1605
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestScrapeLoopAppendExemplarSeries16050 = [1] of {int};
	run TestScrapeLoopAppendExemplarSeries1605(child_TestScrapeLoopAppendExemplarSeries16050)
stop_process:skip
}

proctype TestScrapeLoopAppendExemplarSeries1605(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_append12620 = [1] of {int};
	chan child_append12621 = [1] of {int};
	Mutexdef sl_forcedErrMtx;
	Mutexdef sl_cache_metaMtx;
	Mutexdef discoveryLabels_mtx;
	int scrapeText = -2;
	run mutexMonitor(discoveryLabels_mtx);
	run mutexMonitor(sl_cache_metaMtx);
	run mutexMonitor(sl_forcedErrMtx);
	

	if
	:: scrapeText-1 != -3 -> 
				for(i : 0.. scrapeText-1) {
			for30: skip;
			run append1262(sl_cache_metaMtx,sl_forcedErrMtx,child_append12620);
			child_append12620?0;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for313: skip;
			run append1262(sl_cache_metaMtx,sl_forcedErrMtx,child_append12621);
			child_append12621?0;
			for313_end: skip
		:: true -> 
			break
		od;
		for313_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype append1262(Mutexdef sl_cache_metaMtx;Mutexdef sl_forcedErrMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_iterDone7740 = [1] of {int};
	chan child_forEachStale85921 = [1] of {int};
	chan child_checkAddExemplarError146410 = [1] of {int};
	chan child_addRef8359 = [1] of {int};
	chan child_trackStaleness8558 = [1] of {int};
	chan child_checkAddError14307 = [1] of {int};
	chan child_addDropped8426 = [1] of {int};
	chan child_get8265 = [1] of {int};
	chan child_getDropped8474 = [1] of {int};
	chan child_setType8691 = [1] of {int};
	chan child_setHelp8832 = [1] of {int};
	chan child_setUnit8993 = [1] of {int};
	do
	:: true -> 
		for39: skip;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		

		if
		:: true -> 
			run setType869(sl_cache_metaMtx,child_setType8691);
			child_setType8691?0;
			goto for39_end
		:: true -> 
			run setHelp883(sl_cache_metaMtx,child_setHelp8832);
			child_setHelp8832?0;
			goto for39_end
		:: true -> 
			run setUnit899(sl_cache_metaMtx,child_setUnit8993);
			child_setUnit8993?0;
			goto for39_end
		:: true -> 
			goto for39_end
		fi;
		run getDropped847(sl_cache_metaMtx,child_getDropped8474);
		child_getDropped8474?0;
		

		if
		:: true -> 
			goto for39_end
		:: true;
		fi;
		run get826(sl_cache_metaMtx,child_get8265);
		child_get8265?0;
		

		if
		:: true -> 
			

			if
			:: true -> 
				run addDropped842(sl_cache_metaMtx,child_addDropped8426);
				child_addDropped8426?0;
				goto for39_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto loop
			:: true;
			fi
		fi;
		run checkAddError1430(sl_cache_metaMtx,sl_forcedErrMtx,child_checkAddError14307);
		child_checkAddError14307?0;
		

		if
		:: true -> 
			goto loop
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				run trackStaleness855(sl_cache_metaMtx,child_trackStaleness8558);
				child_trackStaleness8558?0
			:: true;
			fi;
			run addRef835(sl_cache_metaMtx,child_addRef8359);
			child_addRef8359?0
		:: true;
		fi;
		

		if
		:: true -> 
			run checkAddExemplarError1464(sl_cache_metaMtx,sl_forcedErrMtx,child_checkAddExemplarError146410);
			child_checkAddExemplarError146410?0
		:: true;
		fi;
		for39_end: skip
	od;
	for39_exit: skip;
	loop: skip;
	

	if
	:: true -> 
		run forEachStale859(sl_cache_metaMtx,child_forEachStale85921);
		child_forEachStale85921?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run iterDone774(sl_cache_metaMtx,child_iterDone7740);
	child_iterDone7740?0;
	child!0
}
proctype iterDone774(Mutexdef c_metaMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_metaMtx.Lock!false;
	c_metaMtx.Unlock!false;
	

	if
	:: true -> 
		c_metaMtx.Lock!false;
		c_metaMtx.Unlock!false
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype setType869(Mutexdef c_metaMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_metaMtx.Lock!false;
	c_metaMtx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype setHelp883(Mutexdef c_metaMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_metaMtx.Lock!false;
	c_metaMtx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype setUnit899(Mutexdef c_metaMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_metaMtx.Lock!false;
	c_metaMtx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype getDropped847(Mutexdef c_metaMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype get826(Mutexdef c_metaMtx;chan child) {
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
proctype addDropped842(Mutexdef c_metaMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype checkAddError1430(Mutexdef sl_cache_metaMtx;Mutexdef sl_forcedErrMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_trackStaleness8557 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			run trackStaleness855(sl_cache_metaMtx,child_trackStaleness8557);
			child_trackStaleness8557?0
		:: true;
		fi;
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	stop_process: skip;
	child!0
}
proctype trackStaleness855(Mutexdef c_metaMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype addRef835(Mutexdef c_metaMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype checkAddExemplarError1464(Mutexdef sl_cache_metaMtx;Mutexdef sl_forcedErrMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	stop_process: skip;
	child!0
}
proctype forEachStale859(Mutexdef c_metaMtx;chan child) {
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

