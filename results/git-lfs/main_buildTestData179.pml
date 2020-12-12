
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example714267106/t/git-lfs-test-server-api/main.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	Wgdef uploadQueue_errorwait;
	Wgdef uploadQueue_collectorWait;
	int i;
for10_exit:	run wgMonitor(uploadQueue_collectorWait);
	run wgMonitor(uploadQueue_errorwait);
for40_exit:	goto stop_process
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
