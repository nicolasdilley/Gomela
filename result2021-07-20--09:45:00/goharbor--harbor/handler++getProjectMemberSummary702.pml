// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/goharbor/harbor/blob/f8171cdf6e914a08ace62508eabef81ceacfe5a2/src/server/v2.0/handler/project.go#L702
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_getProjectMemberSummary7020 = [1] of {int};
	run getProjectMemberSummary702(child_getProjectMemberSummary7020);
	run receiver(child_getProjectMemberSummary7020)
stop_process:skip
}

proctype getProjectMemberSummary702(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousgetProjectMemberSummary7167160 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 5-1) {
		for10: skip;
		wg.update!1;
		run AnonymousgetProjectMemberSummary716716(wg,child_AnonymousgetProjectMemberSummary7167160);
		run receiver(child_AnonymousgetProjectMemberSummary7167160);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousgetProjectMemberSummary716716(Wgdef wg;chan child) {
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

