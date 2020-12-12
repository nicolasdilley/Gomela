
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example052815095/client/client.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int c_getAllocRunners76622 = -2;
	Wgdef arGroup_wg;
	bool state = false;
	int c_getAllocRunners76022 = -2;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(arGroup_wg);
	
	if
	:: true -> 
				for(i : 0.. c_getAllocRunners76022-1) {
for10:
		}
	:: true -> 
				for(i : 0.. c_getAllocRunners76622-1) {
for20:
		}
	:: true -> 
				for(i : 0.. c_getAllocRunners76622-1) {
for20:
		}
	fi;
	goto stop_process
stop_process:}

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
