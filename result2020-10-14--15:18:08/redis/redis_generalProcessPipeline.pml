#define generalProcessPipeline_cmds  60
#define generalProcessPipeline_cmdsMap  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example941916897/ring.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int cmdsMap = generalProcessPipeline_cmdsMap;
	Wgdef wg;
	bool state = false;
	int cmds = generalProcessPipeline_cmds;
	int i;
		for(i : 1.. cmds) {
for10:
	};
	run wgMonitor(wg);
		for(i : 1.. cmdsMap) {
for20:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
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
