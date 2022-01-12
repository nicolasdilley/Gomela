// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/ping/ping_test.go#L159
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestArgs1590 = [1] of {int};
	run TestArgs159(child_TestArgs1590);
	run receiver(child_TestArgs1590)
stop_process:skip
}

proctype TestArgs159(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_args940 = [1] of {int};
	chan child_args941 = [1] of {int};
	Wgdef p_wg;
	int var_systemCases = -2; // opt var_systemCases
	run wgMonitor(p_wg);
	

	if
	:: var_systemCases-1 != -3 -> 
				for(i : 0.. var_systemCases-1) {
			for10: skip;
			run args94(p_wg,child_args940);
			child_args940?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run args94(p_wg,child_args941);
			child_args941?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype args94(Wgdef p_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true;
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true;
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
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

