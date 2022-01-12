// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grafana/loki/blob//pkg/ingester/mapper_test.go#L58
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFPMapper580 = [1] of {int};
	run TestFPMapper58(child_TestFPMapper580);
	run receiver(child_TestFPMapper580)
stop_process:skip
}

proctype TestFPMapper58(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_mapFP5231 = [1] of {int};
	chan child_mapFP5230 = [1] of {int};
	chan child_mapFP5229 = [1] of {int};
	chan child_mapFP5228 = [1] of {int};
	chan child_mapFP5227 = [1] of {int};
	chan child_mapFP5226 = [1] of {int};
	chan child_mapFP5225 = [1] of {int};
	chan child_mapFP5224 = [1] of {int};
	chan child_mapFP5223 = [1] of {int};
	chan child_mapFP5222 = [1] of {int};
	chan child_mapFP5221 = [1] of {int};
	chan child_mapFP5220 = [1] of {int};
	chan child_mapFP5219 = [1] of {int};
	chan child_mapFP5218 = [1] of {int};
	chan child_mapFP5217 = [1] of {int};
	chan child_mapFP5216 = [1] of {int};
	chan child_mapFP5215 = [1] of {int};
	chan child_mapFP5214 = [1] of {int};
	chan child_mapFP5213 = [1] of {int};
	chan child_mapFP5212 = [1] of {int};
	chan child_mapFP5211 = [1] of {int};
	chan child_mapFP5210 = [1] of {int};
	chan child_mapFP529 = [1] of {int};
	chan child_mapFP528 = [1] of {int};
	chan child_mapFP527 = [1] of {int};
	chan child_mapFP526 = [1] of {int};
	chan child_mapFP525 = [1] of {int};
	chan child_mapFP524 = [1] of {int};
	chan child_mapFP523 = [1] of {int};
	chan child_mapFP522 = [1] of {int};
	chan child_mapFP521 = [1] of {int};
	chan child_mapFP520 = [1] of {int};
	Mutexdef mapper_mtx;
	run mutexMonitor(mapper_mtx);
	run mapFP52(mapper_mtx,child_mapFP520);
	child_mapFP520?0;
	run mapFP52(mapper_mtx,child_mapFP521);
	child_mapFP521?0;
	run mapFP52(mapper_mtx,child_mapFP522);
	child_mapFP522?0;
	run mapFP52(mapper_mtx,child_mapFP523);
	child_mapFP523?0;
	run mapFP52(mapper_mtx,child_mapFP524);
	child_mapFP524?0;
	run mapFP52(mapper_mtx,child_mapFP525);
	child_mapFP525?0;
	run mapFP52(mapper_mtx,child_mapFP526);
	child_mapFP526?0;
	run mapFP52(mapper_mtx,child_mapFP527);
	child_mapFP527?0;
	run mapFP52(mapper_mtx,child_mapFP528);
	child_mapFP528?0;
	run mapFP52(mapper_mtx,child_mapFP529);
	child_mapFP529?0;
	run mapFP52(mapper_mtx,child_mapFP5210);
	child_mapFP5210?0;
	run mapFP52(mapper_mtx,child_mapFP5211);
	child_mapFP5211?0;
	run mapFP52(mapper_mtx,child_mapFP5212);
	child_mapFP5212?0;
	run mapFP52(mapper_mtx,child_mapFP5213);
	child_mapFP5213?0;
	run mapFP52(mapper_mtx,child_mapFP5214);
	child_mapFP5214?0;
	run mapFP52(mapper_mtx,child_mapFP5215);
	child_mapFP5215?0;
	run mapFP52(mapper_mtx,child_mapFP5216);
	child_mapFP5216?0;
	run mapFP52(mapper_mtx,child_mapFP5217);
	child_mapFP5217?0;
	run mapFP52(mapper_mtx,child_mapFP5218);
	child_mapFP5218?0;
	run mapFP52(mapper_mtx,child_mapFP5219);
	child_mapFP5219?0;
	run mapFP52(mapper_mtx,child_mapFP5220);
	child_mapFP5220?0;
	run mapFP52(mapper_mtx,child_mapFP5221);
	child_mapFP5221?0;
	run mapFP52(mapper_mtx,child_mapFP5222);
	child_mapFP5222?0;
	run mapFP52(mapper_mtx,child_mapFP5223);
	child_mapFP5223?0;
	run mapFP52(mapper_mtx,child_mapFP5224);
	child_mapFP5224?0;
	run mapFP52(mapper_mtx,child_mapFP5225);
	child_mapFP5225?0;
	run mapFP52(mapper_mtx,child_mapFP5226);
	child_mapFP5226?0;
	run mapFP52(mapper_mtx,child_mapFP5227);
	child_mapFP5227?0;
	run mapFP52(mapper_mtx,child_mapFP5228);
	child_mapFP5228?0;
	run mapFP52(mapper_mtx,child_mapFP5229);
	child_mapFP5229?0;
	run mapFP52(mapper_mtx,child_mapFP5230);
	child_mapFP5230?0;
	run mapFP52(mapper_mtx,child_mapFP5231);
	child_mapFP5231?0;
	stop_process: skip;
	child!0
}
proctype mapFP52(Mutexdef m_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_maybeAddMapping931 = [1] of {int};
	chan child_maybeAddMapping930 = [1] of {int};
	

	if
	:: true -> 
		run maybeAddMapping93(m_mtx,child_maybeAddMapping930);
		child_maybeAddMapping930?0;
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
		run maybeAddMapping93(m_mtx,child_maybeAddMapping931);
		child_maybeAddMapping931?0;
		goto stop_process
	:: true;
	fi;
	m_mtx.RLock!false;
	m_mtx.RUnlock!false;
	

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
proctype maybeAddMapping93(Mutexdef m_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_nextMappedFP1301 = [1] of {int};
	chan child_nextMappedFP1300 = [1] of {int};
	m_mtx.RLock!false;
	m_mtx.RUnlock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run nextMappedFP130(m_mtx,child_nextMappedFP1300);
		child_nextMappedFP1300?0;
		goto stop_process
	:: true;
	fi;
	run nextMappedFP130(m_mtx,child_nextMappedFP1301);
	child_nextMappedFP1301?0;
	m_mtx.Lock!false;
	m_mtx.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype nextMappedFP130(Mutexdef m_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

proctype receiver(chan c) {
c?0
}

