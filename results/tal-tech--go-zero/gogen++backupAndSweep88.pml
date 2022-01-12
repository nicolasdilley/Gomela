// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//tools/goctl/api/gogen/gen.go#L88
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_backupAndSweep880 = [1] of {int};
	run backupAndSweep88(child_backupAndSweep880);
	run receiver(child_backupAndSweep880)
stop_process:skip
}

proctype backupAndSweep88(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousbackupAndSweep103901 = [1] of {int};
	chan child_AnonymousbackupAndSweep95900 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run AnonymousbackupAndSweep9590(wg,child_AnonymousbackupAndSweep95900);
	run receiver(child_AnonymousbackupAndSweep95900);
	run AnonymousbackupAndSweep10390(wg,child_AnonymousbackupAndSweep103901);
	run receiver(child_AnonymousbackupAndSweep103901);
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousbackupAndSweep9590(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousbackupAndSweep10390(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

