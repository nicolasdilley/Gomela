#define DistributePairs_kvPairs  60
#define DistributePairs_datacenters  60
#define DistributePairs_consulPairs  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example838353898/go/kv/consul.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int kvPairs = DistributePairs_kvPairs;
	bool state = false;
	int consulPairs = DistributePairs_consulPairs;
	Wgdef wg;
	int datacenters = DistributePairs_datacenters;
	int i;
	
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
		for(i : 1.. kvPairs) {
for10:
	};
	run wgMonitor(wg);
		for(i : 1.. datacenters) {
for20:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
		for(i : 1.. consulPairs) {
for21:
	};
	wg.Add!-1;
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
	od;
stop_process:
}
