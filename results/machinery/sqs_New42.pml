
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example309770998/v1/brokers/sqs/sqs.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef b_processingWG;
	int i;
	Wgdef b_receivingWG;
	bool state = false;
	run wgMonitor(b_processingWG);
	run wgMonitor(b_receivingWG);
	goto stop_process
stop_process:}

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
