// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/go-redis/redis/blob//internal/pool/main_test.go#L18
#define def_var_cbs  ?? // mand cbs line 18
#define def_var_n  ?? // mand n line 18
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_perform180 = [1] of {int};
	run perform18(def_var_cbs,def_var_n,child_perform180);
	run receiver(child_perform180)
stop_process:skip
}

proctype perform18(int var_cbs;int var_n;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Anonymousperform23230 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. var_cbs-1) {
		for10: skip;
				for(i : 0.. var_n-1) {
			for11: skip;
			wg.update!1;
			run Anonymousperform2323(wg,child_Anonymousperform23230);
			run receiver(child_Anonymousperform23230);
			for11_end: skip
		};
		for11_exit: skip;
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype Anonymousperform2323(Wgdef wg;chan child) {
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

