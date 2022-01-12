// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//metric/tracking_test.go#L31
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestNewTrackingID310 = [1] of {int};
	run TestNewTrackingID31(child_TestNewTrackingID310);
	run receiver(child_TestNewTrackingID310)
stop_process:skip
}

proctype TestNewTrackingID31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestNewTrackingID43321 = [1] of {int};
	chan child_AnonymousTestNewTrackingID37320 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run AnonymousTestNewTrackingID3732(wg,child_AnonymousTestNewTrackingID37320);
	run receiver(child_AnonymousTestNewTrackingID37320);
	run AnonymousTestNewTrackingID4332(wg,child_AnonymousTestNewTrackingID43321);
	run receiver(child_AnonymousTestNewTrackingID43321);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNewTrackingID3732(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_a = -2; // opt var_a
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNewTrackingID4332(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_b = -2; // opt var_b
	wg.update!-1;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

proctype receiver(chan c) {
c?0
}

