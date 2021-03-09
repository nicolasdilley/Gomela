#define CheckPackages_program_InitialPackages16926  3

// https://github.com/twitchtv/twirp/blob/34efa1812ea53ee8adb60741a6956f33e1695f26/_tools/src/github.com/kisielk/errcheck/internal/errcheck/errcheck.go#L161
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int program_InitialPackages16926 = CheckPackages_program_InitialPackages16926;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. program_InitialPackages16926-1) {
		for10: skip;
		

		if
		:: true -> 
			goto for10_end
		:: true;
		fi;
		wg.Add!1;
		run go_Anonymous0(wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

