
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example162786873/app/multitenant/consul_pipe_router.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef _wait;
	Wgdef bridge_wait;
	bool state = false;
	int i;
	

	if
	:: true -> 
		run wgMonitor(bridge_wait);
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run wgMonitor(_wait)
	:: true;
	fi
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

