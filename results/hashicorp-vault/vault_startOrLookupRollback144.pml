
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example911060269/vault/rollback.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef _WaitGroup;
	Wgdef rs_WaitGroup;
	Wgdef rsInflight_WaitGroup;
	bool state = false;
	int i;
	run wgMonitor(rsInflight_WaitGroup);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(rs_WaitGroup);
	run wgMonitor(_WaitGroup);
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

