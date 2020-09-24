
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example953816283/v1/brokers/redis/redis.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef b_processingWG;
	Wgdef b_consumingWG;
	Wgdef b_delayedWG;
	bool state = false;
	run wgMonitor(b_consumingWG);
	run wgMonitor(b_processingWG);
	run wgMonitor(b_delayedWG);
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
