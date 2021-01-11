
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example328969469/pkg/proxy/winuserspace/proxysocket.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	run wgMonitor(wg);
	wg.Add!2;
	run go_copyBytes(wg);
	run go_copyBytes(wg);
	wg.Wait?0
stop_process:skip
}

proctype go_copyBytes(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
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

