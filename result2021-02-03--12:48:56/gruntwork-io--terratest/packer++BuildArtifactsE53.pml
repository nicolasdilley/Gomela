#define BuildArtifactsE_artifactNameToOptions  3

// https://github.com/gruntwork-io/terratest/blob/d2eada2d8542026fdde0224b0e6b26b3445591ee/modules/packer/packer.go#L53
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef waitForArtifacts;
	int num_msgs = 0;
	bool state = false;
	int i;
	int artifactNameToOptions = BuildArtifactsE_artifactNameToOptions;
	run wgMonitor(waitForArtifacts);
	waitForArtifacts.Add!artifactNameToOptions;
		for(i : 0.. artifactNameToOptions-1) {
		for10: skip;
		run go_Anonymous0(waitForArtifacts);
		for10_end: skip
	};
	for10_exit: skip;
	waitForArtifacts.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef waitForArtifacts) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	waitForArtifacts.Add!-1
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

