// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/gnmi/gnmi_test.go#L421
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestSubscribeResponseError4210 = [1] of {int};
	run TestSubscribeResponseError421(child_TestSubscribeResponseError4210);
	run receiver(child_TestSubscribeResponseError4210)
stop_process:skip
}

proctype TestSubscribeResponseError421(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_handleSubscribeResponse2500 = [1] of {int};
	Wgdef plugin_wg;
	run wgMonitor(plugin_wg);
	run handleSubscribeResponse250(plugin_wg,child_handleSubscribeResponse2500);
	child_handleSubscribeResponse2500?0;
	stop_process: skip;
	child!0
}
proctype handleSubscribeResponse250(Wgdef c_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_handleSubscribeResponseUpdate2600 = [1] of {int};
	

	if
	:: true -> 
		run handleSubscribeResponseUpdate260(c_wg,child_handleSubscribeResponseUpdate2600);
		child_handleSubscribeResponseUpdate2600?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype handleSubscribeResponseUpdate260(Wgdef c_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_handleTelemetryField3351 = [1] of {int};
	chan child_handleTelemetryField3352 = [1] of {int};
	chan child_handlePath3910 = [1] of {int};
	int var_grouper_Metrics = -2; // opt var_grouper_Metrics
	int var_fields = -2; // opt var_fields
	int var_prefixTags = -2; // opt var_prefixTags
	int var_response_Update_Update = -2; // opt var_response_Update_Update
	

	if
	:: true -> 
		run handlePath391(c_wg,child_handlePath3910);
		child_handlePath3910?0
	:: true;
	fi;
	

	if
	:: var_response_Update_Update-1 != -3 -> 
				for(i : 0.. var_response_Update_Update-1) {
			for20: skip;
			run handleTelemetryField335(c_wg,child_handleTelemetryField3351);
			child_handleTelemetryField3351?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for25: skip;
			run handleTelemetryField335(c_wg,child_handleTelemetryField3352);
			child_handleTelemetryField3352?0;
			for25_end: skip
		:: true -> 
			break
		od;
		for25_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype handlePath391(Wgdef c_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_elem_Key = -2; // opt var_elem_Key
	int var_gnmiPath_Elem = -2; // opt var_gnmiPath_Elem
	

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
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype handleTelemetryField335(Wgdef c_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_handlePath3911 = [1] of {int};
	run handlePath391(c_wg,child_handlePath3911);
	child_handlePath3911?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
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

