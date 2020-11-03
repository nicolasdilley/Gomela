#define generalProcessPipeline_cmds 3
#define generalProcessPipeline_cmdsMap 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example639366022/ring.go
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
		for(i : 0.. cmds-1) {
for10:
	};
	run wgMonitor(wg);
		for(i : 0.. cmdsMap-1) {
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
stop_process:	wg.Add!-1
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

