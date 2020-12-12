#define DefineTests_stressTest_testOptions_NumPods  ??
#define DefineTests_stressTest_pods  ??
#define DefineTests_stressTest_snapshots  ??
#define DefineTests_stressTest_volumes  ??
#define DefineTests_stressTest_testOptions_NumSnapshots  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example354285826/test/e2e/storage/testsuites/snapshottable_stress.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef f_logsSizeWaitGroup;
	int stressTest_volumes = DefineTests_stressTest_volumes;
	int stressTest_pods = DefineTests_stressTest_pods;
	int i;
	int stressTest_testOptions_NumPods = DefineTests_stressTest_testOptions_NumPods;
	int stressTest_snapshots = DefineTests_stressTest_snapshots;
	int stressTest_testOptions_NumSnapshots = DefineTests_stressTest_testOptions_NumSnapshots;
	bool state = false;
	run wgMonitor(f_logsSizeWaitGroup)
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
