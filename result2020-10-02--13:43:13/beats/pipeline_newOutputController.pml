
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example116500132/libbeat/publisher/pipeline/controller.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef c_retryer_doneWaiter;
	Wgdef c_consumer_wg;
	Wgdef ctx_retryer_doneWaiter;
	bool state = false;
	run wgMonitor(c_consumer_wg);
	run wgMonitor(c_retryer_doneWaiter);
	run wgMonitor(ctx_retryer_doneWaiter);
	goto stop_process
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
	od;
stop_process:
}
