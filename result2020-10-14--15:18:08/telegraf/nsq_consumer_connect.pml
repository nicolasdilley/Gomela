
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example985353586/plugins/inputs/nsq_consumer/nsq_consumer.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		Wgdef consumer_wg;
		run wgMonitor(consumer_wg);
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		Wgdef n_consumer_wg;
		run wgMonitor(n_consumer_wg)
	:: true;
	fi;
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
	od;
stop_process:
}
