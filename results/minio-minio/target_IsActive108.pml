
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example408925639/pkg/event/target/nsq.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef target_producer_wg;
	Wgdef producer_wg;
	bool state = false;
	int i;
	

	if
	:: true -> 
		run wgMonitor(producer_wg);
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run wgMonitor(target_producer_wg)
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process
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

