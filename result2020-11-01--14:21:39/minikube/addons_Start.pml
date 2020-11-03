#define Start_assets_Addons 3
#define Start_additional 3
#define Start_toEnable 0
#define Start_toEnableList 3
#define Start_enabledAddons 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example715340503/pkg/addons/addons.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int toEnable = Start_toEnable;
	int assets_Addons = Start_assets_Addons;
	int enabledAddons = Start_enabledAddons;
	Wgdef awg;
	int additional = Start_additional;
	int toEnableList = Start_toEnableList;
	int i;
		for(i : 0.. assets_Addons-1) {
for10:
	};
		for(i : 0.. additional-1) {
for20:
	};
		for(i : 0.. toEnable-1) {
for30:
	};
	run wgMonitor(awg);
		for(i : 0.. toEnableList-1) {
for40:		awg.Add!1;
		run Anonymous0(awg)
	};
	awg.Wait?0;
		for(i : 0.. enabledAddons-1) {
for50:
	}
stop_process:}

proctype Anonymous0(Wgdef awg) {
	bool closed; 
	int i;
	bool state;
	awg.Add!-1;
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
	od
}

