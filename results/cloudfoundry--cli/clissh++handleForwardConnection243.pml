
// https://github.com/cloudfoundry/cli/blob/daa64ed559dd33833ed41529fe804079041e7802/util/clissh/ssh.go#L243
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
	run wgMonitor(wg);
	wg.Add!2;
	run go_copyAndClose(wg);
	run go_copyAndClose(wg);
	wg.Wait?0
stop_process:skip
}

proctype go_copyAndClose(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		wg.Add!-1
	:: true;
	fi;
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

