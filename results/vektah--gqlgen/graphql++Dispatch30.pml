#define not_found_m_delayed3921  3

// https://github.com/vektah/gqlgen/blob/997da421b0b80884fcb43c8c6a22d747564b301c/graphql/fieldset.go#L30
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run wgMonitor(wg);
						for(i : 0.. not_found_m_delayed3921-1) {
				for10: skip;
				wg.Add!1;
				run go_Anonymous0(wg);
				for10_end: skip
			};
			for10_exit: skip;
			wg.Wait?0
		:: true;
		fi
	fi
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Add!-1;
	stop_process: skip
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

