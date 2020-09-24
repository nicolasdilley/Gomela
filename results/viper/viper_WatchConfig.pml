#define lb_for364_0  -1
#define ub_for364_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example052462378/viper.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef initWG;
	bool state = false;
	run wgMonitor(initWG);
	initWG.Add!1;
	run Anonymous0();
	initWG.Wait?0
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		od
	od;
for10_exit:stop_process:
}
proctype Anonymous0() {
	bool closed; 
	int i;
	Wgdef eventsWG;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(eventsWG);
	eventsWG.Add!1;
	run Anonymous0();
	eventsWG.Wait?0;
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
