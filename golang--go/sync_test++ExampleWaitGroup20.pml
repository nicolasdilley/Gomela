// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/sync/example_test.go#L20
#define ExampleWaitGroup_urls  ??
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_ExampleWaitGroup200 = [1] of {int};
	run ExampleWaitGroup20(child_ExampleWaitGroup200);
	run receiver(child_ExampleWaitGroup200)
stop_process:skip
}

proctype ExampleWaitGroup20(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousExampleWaitGroup31310 = [1] of {int};
	Wgdef wg;
	int var_urls = ExampleWaitGroup_urls; // mand var_urls
	run wgMonitor(wg);
		for(i : 0.. var_urls-1) {
		for10: skip;
		wg.update!1;
		run AnonymousExampleWaitGroup3131(wg,child_AnonymousExampleWaitGroup31310);
		run receiver(child_AnonymousExampleWaitGroup31310);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousExampleWaitGroup3131(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
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

