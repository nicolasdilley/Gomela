// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/ravendb/ravendb.go#L91
#define def_var_r_StatsInclude94  ?? // mand r.StatsInclude line 94
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Gather910 = [1] of {int};
	run Gather91(child_Gather910);
	run receiver(child_Gather910)
stop_process:skip
}

proctype Gather91(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGather99920 = [1] of {int};
	chan child_AnonymousGather104921 = [1] of {int};
	chan child_AnonymousGather109922 = [1] of {int};
	chan child_AnonymousGather114923 = [1] of {int};
	Wgdef wg;
	int var_r_StatsInclude = def_var_r_StatsInclude94; // mand var_r_StatsInclude
	run wgMonitor(wg);
		for(i : 0.. var_r_StatsInclude-1) {
		for10: skip;
		wg.update!1;
		

		if
		:: true -> 
			run AnonymousGather9992(wg,child_AnonymousGather99920);
			run receiver(child_AnonymousGather99920)
		:: true -> 
			run AnonymousGather10492(wg,child_AnonymousGather104921);
			run receiver(child_AnonymousGather104921)
		:: true -> 
			run AnonymousGather10992(wg,child_AnonymousGather109922);
			run receiver(child_AnonymousGather109922)
		:: true -> 
			run AnonymousGather11492(wg,child_AnonymousGather114923);
			run receiver(child_AnonymousGather114923)
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGather9992(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousGather10492(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousGather10992(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousGather11492(Wgdef wg;chan child) {
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

