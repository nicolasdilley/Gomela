
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example632096367/pkg/addons/addons.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef awg;
	int enabledAddons = 5;
	int toEnableList = 5;
	bool state = false;
	int assets_Addons = 5;
	int deferredAddons = 5;
	int i;
		for(i : 1.. assets_Addons) {
for10:
	};
		for(i : 1.. additional) {
for20:
	};
		for(i : 1.. toEnable) {
for30:
	};
	run wgMonitor(awg);
		for(i : 1.. toEnableList) {
for40:		awg.Add!1;
		run Anonymous0(awg)
	};
	awg.Wait?0;
		for(i : 1.. deferredAddons) {
for50:
	};
		for(i : 1.. enabledAddons) {
for60:
	}
stop_process:}

proctype Anonymous0(Wgdef awg) {
	bool closed; 
	int i;
	awg.Add!-1;
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
