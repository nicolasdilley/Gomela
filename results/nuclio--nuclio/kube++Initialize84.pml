
// https://github.com/nuclio/nuclio/blob/72501aefe67e58c915680d0d457006424076f081/pkg/platform/kube/function.go#L84
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef waitGroup;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(waitGroup);
	waitGroup.Add!3;
	run go_Anonymous0(waitGroup);
	run go_Anonymous1(waitGroup);
	run go_Anonymous2(waitGroup);
	waitGroup.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef waitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	waitGroup.Add!-1;
	stop_process: skip
}
proctype go_Anonymous1(Wgdef waitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	waitGroup.Add!-1;
	stop_process: skip
}
proctype go_Anonymous2(Wgdef waitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	waitGroup.Add!-1;
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

