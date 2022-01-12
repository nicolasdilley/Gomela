// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/ping/ping_test.go#L488
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestNoPacketsSent4880 = [1] of {int};
	run TestNoPacketsSent488(child_TestNoPacketsSent4880);
	run receiver(child_TestNoPacketsSent4880)
stop_process:skip
}

proctype TestNoPacketsSent488(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_pingToURLNative2261 = [1] of {int};
	chan child_Init3190 = [1] of {int};
	Wgdef p_wg;
	run wgMonitor(p_wg);
	run Init319(p_wg,child_Init3190);
	child_Init3190?0;
	run pingToURLNative226(p_wg,child_pingToURLNative2261);
	child_pingToURLNative2261?0;
	stop_process: skip;
	child!0
}
proctype Init319(Wgdef p_wg;chan child) {
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
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype pingToURLNative226(Wgdef p_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_p_Percentiles = -2; // opt var_p_Percentiles
	

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
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
	fi;
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

