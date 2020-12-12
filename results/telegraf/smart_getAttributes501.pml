#define getAttributes_devices  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example359059926/plugins/inputs/smart/smart.go
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
	wg.Wait?0
stop_process:}

proctype go_smartgatherDisk(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int keys = -2;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for662_1 != -2 && ub_for662_2 != -2 -> 
				for(i : lb_for662_1.. ub_for662_2) {
for11:			
			if
			:: true -> 
								for(i : 0.. keys-1) {
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
								for(i : 0.. keys-1) {
for12:
				}
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for11_exit:stop_process:	wg.Add!-1
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
	od
}
