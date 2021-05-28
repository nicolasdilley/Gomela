// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/compress/flate/deflate_test.go#L956
#define TestMaxStackSize_BestCompression  ??
#define TestMaxStackSize_HuffmanOnly  ??
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestMaxStackSize9560 = [1] of {int};
	run TestMaxStackSize956(child_TestMaxStackSize9560);
	run receiver(child_TestMaxStackSize9560)
stop_process:skip
}

proctype TestMaxStackSize956(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestMaxStackSize9699690 = [1] of {int};
	Wgdef wg;
	int HuffmanOnly = TestMaxStackSize_HuffmanOnly; // mand HuffmanOnly
	int BestCompression = TestMaxStackSize_BestCompression; // mand BestCompression
	run wgMonitor(wg);
		for(i : 0.. BestCompression) {
		for10: skip;
		wg.update!1;
		run AnonymousTestMaxStackSize969969(wg,child_AnonymousTestMaxStackSize9699690);
		run receiver(child_AnonymousTestMaxStackSize9699690);
		for10_end: skip
	};
	for10_exit: skip;
		defer1: skip;
	wg.wait?0;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestMaxStackSize969969(Wgdef wg;chan child) {
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

