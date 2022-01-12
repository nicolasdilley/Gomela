// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/openweathermap/openweathermap.go#L84
#define def_var_n_Fetch88  ?? // mand n.Fetch line 88
#define def_var_n_CityID90  ?? // mand n.CityID line 90
#define ub_for106_4  ??
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Gather840 = [1] of {int};
	run Gather84(child_Gather840);
	run receiver(child_Gather840)
stop_process:skip
}

proctype Gather84(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGather93850 = [1] of {int};
	chan child_AnonymousGather116852 = [1] of {int};
	Wgdef wg;
	int var_n_CityID = def_var_n_CityID90; // mand var_n_CityID
	int var_n_Fetch = def_var_n_Fetch88; // mand var_n_Fetch
	run wgMonitor(wg);
		for(i : 0.. var_n_Fetch-1) {
		for10: skip;
		

		if
		:: true -> 
						for(i : 0.. var_n_CityID-1) {
				for11: skip;
				wg.update!1;
				run AnonymousGather9385(wg,child_AnonymousGather93850);
				run receiver(child_AnonymousGather93850);
				for11_end: skip
			};
			for11_exit: skip
		:: true -> 
			

			if
			:: true -> 
								for(i : 0.. ub_for106_4) {
					for13: skip;
					wg.update!1;
					run AnonymousGather11685(wg,child_AnonymousGather116852);
					run receiver(child_AnonymousGather116852);
					for13_end: skip
				};
				for13_exit: skip
			:: true;
			fi
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGather9385(Wgdef wg;chan child) {
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
proctype AnonymousGather11685(Wgdef wg;chan child) {
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

