#define Gather_n_Fetch  1
#define Gather_n_CityId  1
#define ub_for106_2  1

// https://github.com/influxdata/telegraf/blob/6ed1431348c200760443c2a0422b0d54bea927ec/plugins/inputs/openweathermap/openweathermap.go#L84
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int n_CityId = Gather_n_CityId;
	int n_Fetch = Gather_n_Fetch;
	run wgMonitor(wg);
		for(i : 0.. n_Fetch-1) {
		for10: skip;
		

		if
		:: true -> 
						for(i : 0.. n_CityId-1) {
				for11: skip;
				wg.Add!1;
				run go_Anonymous0(wg);
				for11_end: skip
			};
			for11_exit: skip
		:: true -> 
			

			if
			:: true -> 
								for(i : 0.. ub_for106_2) {
					for11: skip;
					wg.Add!1;
					run go_Anonymous1(wg);
					for11_end: skip
				};
				for11_exit: skip
			:: true;
			fi
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

