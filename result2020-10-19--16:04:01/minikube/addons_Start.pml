#define Start_assets_Addons  5
#define Start_additional  5
#define Start_toEnable  5
#define Start_toEnableList  5
#define Start_enabledAddons  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example510198664/pkg/addons/addons.go
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
		for(i : 1.. enabledAddons) {
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
	od;
stop_process:
}
