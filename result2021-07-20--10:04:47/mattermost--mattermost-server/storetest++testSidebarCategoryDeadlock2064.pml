// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/mattermost/mattermost-server/blob/5c16de58a02099df38e1e8486df148d1b798460a/store/storetest/channel_store_categories.go#L2064
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_testSidebarCategoryDeadlock20640 = [1] of {int};
	run testSidebarCategoryDeadlock2064(child_testSidebarCategoryDeadlock20640);
	run receiver(child_testSidebarCategoryDeadlock20640)
stop_process:skip
}

proctype testSidebarCategoryDeadlock2064(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoustestSidebarCategoryDeadlock211720961 = [1] of {int};
	chan child_AnonymoustestSidebarCategoryDeadlock209920960 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run AnonymoustestSidebarCategoryDeadlock20992096(wg,child_AnonymoustestSidebarCategoryDeadlock209920960);
	run receiver(child_AnonymoustestSidebarCategoryDeadlock209920960);
	run AnonymoustestSidebarCategoryDeadlock21172096(wg,child_AnonymoustestSidebarCategoryDeadlock211720961);
	run receiver(child_AnonymoustestSidebarCategoryDeadlock211720961);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymoustestSidebarCategoryDeadlock20992096(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymoustestSidebarCategoryDeadlock21172096(Wgdef wg;chan child) {
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

