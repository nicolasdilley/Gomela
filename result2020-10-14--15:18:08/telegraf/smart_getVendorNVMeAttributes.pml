#define getVendorNVMeAttributes_NVMeDevices  60
#define lb_for631_1  -1
#define ub_for631_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example985353586/plugins/inputs/smart/smart.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int NVMeDevices = getVendorNVMeAttributes_NVMeDevices;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. NVMeDevices) {
for10:		
		if
		:: true -> 
			

			if
			:: true -> 
				wg.Add!1;
				run go_smartgatherIntelNVMeDisk(wg)
			fi
		:: true -> 
			
			if
			:: true -> 
				wg.Add!1;
				run go_smartgatherIntelNVMeDisk(wg)
			:: true;
			fi
		fi
	};
	wg.Wait?0
stop_process:}

proctype go_smartgatherIntelNVMeDisk(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for631_1 != -1 && ub_for631_2 != -1 -> 
				for(i : lb_for631_1.. ub_for631_2) {
for11:
		}
	:: else -> 
		do
		:: true -> 
for11:
		:: true -> 
			break
		od
	fi;
for11_exit:	wg.Add!-1;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od;
stop_process:
}
