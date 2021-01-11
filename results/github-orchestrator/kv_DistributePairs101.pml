#define DistributePairs_datacenters  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example911523092/go/kv/consul.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int datacenters = DistributePairs_datacenters;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. datacenters-1) {
		for20: skip;
		wg.Add!1;
		run go_Anonymous0(wg);
		for20_end: skip
	};
	for20_exit: skip;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
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

