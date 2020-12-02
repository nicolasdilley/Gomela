#define eachMapP_keys  3

// /tmp/clone-example118622225/each.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef done;
	int i;
	int keys = eachMapP_keys;
	bool state = false;
	run wgMonitor(done);
	done.Add!keys;
	done.Wait?0
stop_process:}

proctype Anonymous0(Wgdef done) {
	bool closed; 
	int i;
	bool state;
	done.Add!-1;
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
