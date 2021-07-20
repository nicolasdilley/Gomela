// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/ui_test.go#L133
#define not_found_160  -2 // opt values line 113
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_DefaultHeaders1330 = [1] of {int};
	run TestConfig_DefaultHeaders133(child_TestConfig_DefaultHeaders1330);
	run receiver(child_TestConfig_DefaultHeaders1330)
stop_process:skip
}

proctype TestConfig_DefaultHeaders133(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Headers546 = [1] of {int};
	chan child_DeleteHeader1385 = [1] of {int};
	chan child_Headers544 = [1] of {int};
	chan child_SetHeader1133 = [1] of {int};
	chan child_Headers542 = [1] of {int};
	chan child_Headers541 = [1] of {int};
	chan child_NewUIConfig330 = [1] of {int};
	Mutexdef config_l;
	Mutexdef logl_once_m;
	run mutexMonitor(logl_once_m);
	run mutexMonitor(config_l);
	run NewUIConfig33(logl_once_m,child_NewUIConfig330);
	child_NewUIConfig330?0;
	run Headers54(config_l,child_Headers541);
	child_Headers541?0;
	run Headers54(config_l,child_Headers542);
	child_Headers542?0;
	run SetHeader113(config_l,not_found_160,child_SetHeader1133);
	child_SetHeader1133?0;
	run Headers54(config_l,child_Headers544);
	child_Headers544?0;
	run DeleteHeader138(config_l,child_DeleteHeader1385);
	child_DeleteHeader1385?0;
	run Headers54(config_l,child_Headers546);
	child_Headers546?0;
	stop_process: skip;
	child!0
}
proctype NewUIConfig33(Mutexdef barrierStorage_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Headers54(Mutexdef c_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get1541 = [1] of {int};
	int var_c_defaultHeadersc_defaultHeaders = -2; // opt var_c_defaultHeadersc_defaultHeaders
	c_l.RLock!false;
	run get154(c_l,child_get1541);
	child_get1541?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_l.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype get154(Mutexdef c_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_save1951 = [1] of {int};
	

	if
	:: true -> 
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			run save195(c_l,child_save1951);
			child_save1951?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype save195(Mutexdef c_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetHeader113(Mutexdef c_l;int values;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_save1954 = [1] of {int};
	chan child_get1543 = [1] of {int};
	c_l.Lock!false;
	run get154(c_l,child_get1543);
	child_get1543?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run save195(c_l,child_save1954);
	child_save1954?0;
	goto defer1;
		defer1: skip;
	c_l.Unlock!false;
	stop_process: skip;
	child!0
}
proctype DeleteHeader138(Mutexdef c_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_save1956 = [1] of {int};
	chan child_get1545 = [1] of {int};
	c_l.Lock!false;
	run get154(c_l,child_get1545);
	child_get1545?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run save195(c_l,child_save1956);
	child_save1956?0;
	goto defer1;
		defer1: skip;
	c_l.Unlock!false;
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

