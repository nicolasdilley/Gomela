// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/evanw/esbuild/blob/7d25497064e8a2a3f83c779dc29da2596bb60d0f/internal/bundler/bundler.go#L2005
#define reachableFiles2005  ?? // mand reachableFiles2005
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_computeDataForSourceMapsInParallel20050 = [1] of {int};
	run computeDataForSourceMapsInParallel2005(reachableFiles2005,child_computeDataForSourceMapsInParallel20050);
	run receiver(child_computeDataForSourceMapsInParallel20050)
stop_process:skip
}

proctype computeDataForSourceMapsInParallel2005(int reachableFiles;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymouscomputeDataForSourceMapsInParallel201920190 = [1] of {int};
	Wgdef waitGroup;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(waitGroup);
		for(i : 0.. reachableFiles-1) {
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: true -> 
				waitGroup.update!1;
				run AnonymouscomputeDataForSourceMapsInParallel20192019(waitGroup,child_AnonymouscomputeDataForSourceMapsInParallel201920190);
				run receiver(child_AnonymouscomputeDataForSourceMapsInParallel201920190)
			:: true;
			fi
		:: true;
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymouscomputeDataForSourceMapsInParallel20192019(Wgdef waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int sm_Sources = -2; // opt sm_Sources
	waitGroup.update!-1;
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

