
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example780332040/testonly/integration/logenv.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef sequencerTask_runnerWG;
	Wgdef wg;
	Wgdef grpcServer_serveWG;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(grpcServer_serveWG);
	run wgMonitor(wg);
	run wgMonitor(sequencerTask_runnerWG);
	wg.Add!1;
	run go_Anonymous0(wg);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Add!1;
	run go_Anonymous1(wg);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

