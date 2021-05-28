// num_comm_params=2
// num_mand_comm_params=1
// num_opt_comm_params=1

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/timeout_test.go#L157
#define TestAcceptTimeout_acceptTimeoutTests  ??
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestAcceptTimeout1570 = [1] of {int};
	run TestAcceptTimeout157(child_TestAcceptTimeout1570);
	run receiver(child_TestAcceptTimeout1570)
stop_process:skip
}

proctype TestAcceptTimeout157(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestAcceptTimeout1761720 = [1] of {int};
	Wgdef wg;
	int tt_xerrs = -2; // opt tt_xerrs
	int acceptTimeoutTests = TestAcceptTimeout_acceptTimeoutTests; // mand acceptTimeoutTests
	

	if
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. acceptTimeoutTests-1) {
		for10: skip;
		

		if
		:: true -> 
			wg.update!1;
			run AnonymousTestAcceptTimeout176172(wg,child_AnonymousTestAcceptTimeout1761720);
			run receiver(child_AnonymousTestAcceptTimeout1761720)
		:: true;
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestAcceptTimeout176172(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
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

