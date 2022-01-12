// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/smart/smart.go#L517
#define def_var_NVMeDevices522  ?? // mand NVMeDevices line 522
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_getVendorNVMeAttributes5170 = [1] of {int};
	run getVendorNVMeAttributes517(child_getVendorNVMeAttributes5170);
	run receiver(child_getVendorNVMeAttributes5170)
stop_process:skip
}

proctype getVendorNVMeAttributes517(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_gatherIntelNVMeDisk5970 = [1] of {int};
	chan child_gatherIntelNVMeDisk5971 = [1] of {int};
	Wgdef wg;
	int var_NVMeDevices = def_var_NVMeDevices522; // mand var_NVMeDevices
	run wgMonitor(wg);
		for(i : 0.. var_NVMeDevices-1) {
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: true -> 
				wg.update!1;
				run gatherIntelNVMeDisk597(wg,child_gatherIntelNVMeDisk5970);
				run receiver(child_gatherIntelNVMeDisk5970)
			fi
		:: true -> 
			

			if
			:: true -> 
				wg.update!1;
				run gatherIntelNVMeDisk597(wg,child_gatherIntelNVMeDisk5971);
				run receiver(child_gatherIntelNVMeDisk5971)
			:: true;
			fi
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype gatherIntelNVMeDisk597(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	wg.update!-1;
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

proctype receiver(chan c) {
c?0
}

