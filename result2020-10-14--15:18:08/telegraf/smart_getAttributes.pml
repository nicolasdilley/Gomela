#define getAttributes_devices  60
#define gatherDisk_keys  60
#define lb_for685_2  -1
#define ub_for685_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example985353586/plugins/inputs/smart/smart.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int devices = getAttributes_devices;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!devices;
		for(i : 1.. devices) {
for10:		run go_smartgatherDisk(wg)
	};
	wg.Wait?0
stop_process:}

proctype go_smartgatherDisk(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for685_2 != -1 && ub_for685_3 != -1 -> 
				for(i : lb_for685_2.. ub_for685_3) {
for11:			
			if
			:: true -> 
								for(i : 1.. keys) {
for12:
				}
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for11:			
			if
			:: true -> 
								for(i : 1.. keys) {
for12:
				}
			:: true;
			fi
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
