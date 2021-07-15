
// https://github.com/rclone/rclone/blob/master/backend/jottacloud/jottacloud.go#L421
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_v2config4210 = [1] of {int};
	run v2config421(child_v2config4210)
stop_process:skip
}

proctype v2config421(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setupMountpoint5211 = [1] of {int};
	Mutexdef apiSrv_mu;
	Mutexdef __mu;
	chan child_doAuthV24610 = [1] of {int};
	Mutexdef srv_mu;
	run mutexMonitor(srv_mu);
	run doAuthV2461(srv_mu,child_doAuthV24610);
	child_doAuthV24610?0;
	

	if
	:: true -> 
		run mutexMonitor(__mu);
		run mutexMonitor(apiSrv_mu);
		run setupMountpoint521(srv_mu,apiSrv_mu,child_setupMountpoint5211);
		child_setupMountpoint5211?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype doAuthV2461(Mutexdef srv_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype setupMountpoint521(Mutexdef srv_mu;Mutexdef apiSrv_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getDeviceInfo5863 = [1] of {int};
	chan child_getDriveInfo5712 = [1] of {int};
	chan child_getCustomerInfo5561 = [1] of {int};
	run getCustomerInfo556(apiSrv_mu,child_getCustomerInfo5561);
	child_getCustomerInfo5561?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getDriveInfo571(srv_mu,child_getDriveInfo5712);
	child_getDriveInfo5712?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getDeviceInfo586(srv_mu,child_getDeviceInfo5863);
	child_getDeviceInfo5863?0;
	

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
proctype getCustomerInfo556(Mutexdef srv_mu;chan child) {
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
proctype getDriveInfo571(Mutexdef srv_mu;chan child) {
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
proctype getDeviceInfo586(Mutexdef srv_mu;chan child) {
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

