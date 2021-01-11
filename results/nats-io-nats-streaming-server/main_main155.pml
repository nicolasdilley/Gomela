
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example596577888/nats-streaming-server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef __ioChannelWG;
	Wgdef __wg;
	bool state = false;
	int i;
	run wgMonitor(__wg);
	run wgMonitor(__ioChannelWG)
stop_process:skip
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

