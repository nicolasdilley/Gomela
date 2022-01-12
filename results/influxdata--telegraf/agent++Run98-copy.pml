// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//agent/agent.go#L98
#define def_var_a_Config_AggProcessors123  3 // mand a.Config.AggProcessors line 123
#define def_var_a_Config_Processors134  1 // mand a.Config.Processors line 134
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Run980 = [1] of {int};
	run Run98(child_Run980);
	run receiver(child_Run980)
stop_process:skip
}

proctype Run98(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousRun1751454 = [1] of {int};
	chan child_AnonymousRun1681453 = [1] of {int};
	chan child_AnonymousRun1601452 = [1] of {int};
	chan child_AnonymousRun1541451 = [1] of {int};
	chan child_AnonymousRun1471450 = [1] of {int};
	Wgdef wg;
	int var_a_Config_Inputs = -2; // opt var_a_Config_Inputs
	int var_a_Config_Processors = def_var_a_Config_Processors134; // mand var_a_Config_Processors
	int var_a_Config_AggProcessors = def_var_a_Config_AggProcessors123; // mand var_a_Config_AggProcessors
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousRun147145(wg,child_AnonymousRun1471450);
	run receiver(child_AnonymousRun1471450);
	

	if
	:: true -> 
		wg.update!1;
		run AnonymousRun154145(wg,child_AnonymousRun1541451);
		run receiver(child_AnonymousRun1541451);
		wg.update!1;
		run AnonymousRun160145(wg,child_AnonymousRun1601452);
		run receiver(child_AnonymousRun1601452)
	:: true;
	fi;
	

	if
	:: true -> 
		wg.update!1;
		run AnonymousRun168145(wg,child_AnonymousRun1681453);
		run receiver(child_AnonymousRun1681453)
	:: true;
	fi;
	wg.update!1;
	run AnonymousRun175145(wg,child_AnonymousRun1751454);
	run receiver(child_AnonymousRun1751454);
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousRun147145(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousRun154145(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousRun160145(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousRun168145(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousRun175145(Wgdef wg;chan child) {
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

