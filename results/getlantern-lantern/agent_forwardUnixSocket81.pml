
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example512321996/archive/src/golang.org/x/crypto/ssh/agent/forward.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	wg.Add!2;
	run go_Anonymous0(wg);
	run go_Anonymous1(wg);
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
	stop_process: skip
}
proctype go_Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
	stop_process: skip
}
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

