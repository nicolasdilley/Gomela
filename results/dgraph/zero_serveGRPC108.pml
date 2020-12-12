
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example913407792/dgraph/cmd/zero/run.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef s_serveWG;
	bool state = false;
	run wgMonitor(s_serveWG);
	run Anonymous0()
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
	Chandef done;
	run sync_monitor(done);
	run Anonymous0();
	do
	:: done.async_rcv?0 -> 
		break
	:: done.sync?0 -> 
		break
	:: true -> 
		break
	od;
stop_process:
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
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
}
