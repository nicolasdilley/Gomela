// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//agent/agent.go#L977
#define def_var_a_Config_AggProcessors997  3 // mand a.Config.AggProcessors line 997
#define def_var_a_Config_Processors1008  3 // mand a.Config.Processors line 1008
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_once9770 = [1] of {int};
	run once977(child_once9770);
	run receiver(child_once9770)
stop_process:skip
}

proctype once977(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Anonymousonce104610164 = [1] of {int};
	chan child_Anonymousonce103910163 = [1] of {int};
	chan child_Anonymousonce103110162 = [1] of {int};
	chan child_Anonymousonce102510161 = [1] of {int};
	chan child_Anonymousonce101810160 = [1] of {int};
	Wgdef wg;
	int var_a_Config_Inputs = -2; // opt var_a_Config_Inputs
	int var_a_Config_Processors = def_var_a_Config_Processors1008; // mand var_a_Config_Processors
	int var_a_Config_AggProcessors = def_var_a_Config_AggProcessors997; // mand var_a_Config_AggProcessors
	

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
	run wgMonitor(wg);
	wg.update!1;
	run Anonymousonce10181016(wg,child_Anonymousonce101810160);
	run receiver(child_Anonymousonce101810160);
	

	if
	:: true -> 
		wg.update!1;
		run Anonymousonce10251016(wg,child_Anonymousonce102510161);
		run receiver(child_Anonymousonce102510161);
		wg.update!1;
		run Anonymousonce10311016(wg,child_Anonymousonce103110162);
		run receiver(child_Anonymousonce103110162)
	:: true;
	fi;
	

	if
	:: true -> 
		wg.update!1;
		run Anonymousonce10391016(wg,child_Anonymousonce103910163);
		run receiver(child_Anonymousonce103910163)
	:: true;
	fi;
	wg.update!1;
	run Anonymousonce10461016(wg,child_Anonymousonce104610164);
	run receiver(child_Anonymousonce104610164);
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Anonymousonce10181016(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Anonymousonce10251016(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Anonymousonce10311016(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Anonymousonce10391016(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Anonymousonce10461016(Wgdef wg;chan child) {
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

