#define toEnableList  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example641972900/pkg/addons/addons.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int toEnableList = 5;
	Wgdef awg;
	bool state = false;
	int assets_Addons = 5;
	int i;
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
	do
	:: true -> 
for20:
	:: true -> 
		break
	od;
	do
	:: true -> 
for30:
	:: true -> 
		break
	od;
	run wgMonitor(awg);
		for(i : 1.. toEnableList) {
for40:		awg.Add!1;
		run Anonymous0(awg)
	};
	awg.Wait?0;
	do
	:: true -> 
for50:
	:: true -> 
		break
	od
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
