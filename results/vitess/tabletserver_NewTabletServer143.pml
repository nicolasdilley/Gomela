
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example476275474/go/vt/vttablet/tabletserver/tabletserver.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef tsv_tracker_wg;
	int i;
	Wgdef tsv_te_beginRequests;
	Wgdef tsv_vstreamer_wg;
	Wgdef tsv_watcher_wg;
	Wgdef tsv_sm_requests;
	bool state = false;
	run wgMonitor(tsv_vstreamer_wg);
	run wgMonitor(tsv_tracker_wg);
	run wgMonitor(tsv_watcher_wg);
	run wgMonitor(tsv_te_beginRequests);
	run wgMonitor(tsv_sm_requests);
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
