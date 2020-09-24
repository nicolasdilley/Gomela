#define lb_for313_0  -1
#define ub_for313_1  -1
#define devices  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example628089191/plugins/inputs/smart/smart.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for313_0 != -1 && ub_for313_1 != -1 -> 
				for(i : lb_for313_0.. ub_for313_1) {
for11:			
			if
			:: true -> 
				do
				:: true -> 
for12:
				:: true -> 
					break
				od
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for11:			
			if
			:: true -> 
				do
				:: true -> 
for12:
				:: true -> 
					break
				od
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
