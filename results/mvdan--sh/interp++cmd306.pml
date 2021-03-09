
// https://github.com/mvdan/sh/blob/b8bd8e57547725220dbf237072b80e40c09a0502/interp/runner.go#L306
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
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	:: true -> 
		

		if
		:: true -> 
			break
		:: true;
		fi
	:: true -> 
		

		if
		:: true;
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run wgMonitor(wg);
			wg.Add!1;
			run go_Anonymous0(wg);
			wg.Wait?0
		fi
	:: true -> 
		

		if
		:: true -> 
			break
		:: true;
		fi
	:: true;
	:: true -> 
		

		if
		:: true;
		:: true;
		fi
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
		

		if
		:: true;
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		:: true;
		:: true;
		fi
	:: true;
	:: true;
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

