// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob/6ef7178ee4465f2361b6e2cf483cef5bbfd9c95c/backend/union/union.go#L888
#define var_num  ?? // mand num line 888
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_multithread8880 = [1] of {int};
	run multithread888(var_num,child_multithread8880);
	run receiver(child_multithread8880)
stop_process:skip
}

proctype multithread888(int num;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Anonymousmultithread8938890 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. var_num-1) {
		for10: skip;
		wg.update!1;
		run Anonymousmultithread893889(wg,child_Anonymousmultithread8938890);
		run receiver(child_Anonymousmultithread8938890);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype Anonymousmultithread893889(Wgdef wg;chan child) {
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

