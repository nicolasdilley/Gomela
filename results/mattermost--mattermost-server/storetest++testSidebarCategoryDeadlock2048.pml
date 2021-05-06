
// https://github.com/mattermost/mattermost-server/blob/master/store/storetest/channel_store_categories.go#L2048
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_testSidebarCategoryDeadlock20480 = [1] of {int};
	run testSidebarCategoryDeadlock2048(child_testSidebarCategoryDeadlock20480)
stop_process:skip
}

proctype testSidebarCategoryDeadlock2048(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoustestSidebarCategoryDeadlock210120801 = [1] of {int};
	chan child_AnonymoustestSidebarCategoryDeadlock208320800 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run AnonymoustestSidebarCategoryDeadlock20832080(wg,child_AnonymoustestSidebarCategoryDeadlock208320800);
	run AnonymoustestSidebarCategoryDeadlock21012080(wg,child_AnonymoustestSidebarCategoryDeadlock210120801);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymoustestSidebarCategoryDeadlock20832080(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype AnonymoustestSidebarCategoryDeadlock21012080(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		wg.update!-1;
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

