#define testReboot_nodelist_Items  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example603064843/test/e2e/cloud/gcp/reboot.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int nodelist_Items = testReboot_nodelist_Items;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!nodelist_Items;
		for(i : 1.. nodelist_Items) {
for10:		run Anonymous0()
	};
	wg.Wait?0;
	
	if
	:: true -> 
				for(i : 1.. nodelist_Items) {
for20:
		}
	:: true;
	fi
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
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
