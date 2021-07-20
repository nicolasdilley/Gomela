// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob/6ef7178ee4465f2361b6e2cf483cef5bbfd9c95c/backend/jottacloud/jottacloud.go#L246
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_teliaCloudConfig2460 = [1] of {int};
	run teliaCloudConfig246(child_teliaCloudConfig2460);
	run receiver(child_teliaCloudConfig2460)
stop_process:skip
}

proctype teliaCloudConfig246(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setupMountpoint5240 = [1] of {int};
	Mutexdef apiSrv_mu;
	Mutexdef srv_mu;
	Mutexdef __mu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run mutexMonitor(__mu);
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run mutexMonitor(srv_mu);
		run mutexMonitor(apiSrv_mu);
		run setupMountpoint524(srv_mu,apiSrv_mu,child_setupMountpoint5240);
		child_setupMountpoint5240?0;
		

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
proctype setupMountpoint524(Mutexdef srv_mu;Mutexdef apiSrv_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getDeviceInfo5892 = [1] of {int};
	chan child_getDriveInfo5741 = [1] of {int};
	chan child_getCustomerInfo5590 = [1] of {int};
	int var_dev_MountPointsdev_MountPoints = -2; // opt var_dev_MountPointsdev_MountPoints
	int var_acc_Devicesacc_Devices = -2; // opt var_acc_Devicesacc_Devices
	run getCustomerInfo559(apiSrv_mu,child_getCustomerInfo5590);
	child_getCustomerInfo5590?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getDriveInfo574(srv_mu,child_getDriveInfo5741);
	child_getDriveInfo5741?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getDeviceInfo589(srv_mu,child_getDeviceInfo5892);
	child_getDeviceInfo5892?0;
	

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
proctype getCustomerInfo559(Mutexdef srv_mu;chan child) {
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
proctype getDriveInfo574(Mutexdef srv_mu;chan child) {
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
proctype getDeviceInfo589(Mutexdef srv_mu;chan child) {
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

proctype receiver(chan c) {
c?0
}

