
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example862180471/go/vt/worker/split_clone.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int scw_sourceShards = 5;
	Wgdef wg;
	int scw_destinationShards = 5;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: true -> 
				for(i : 1.. scw_sourceShards) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: true -> 
				for(i : 1.. scw_sourceShards) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	fi;
		for(i : 1.. scw_destinationShards) {
for20:		wg.Add!1;
		run Anonymous0()
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
		for(i : 1.. scw_sourceShards) {
for21:		do
		:: true -> 
			goto stop_process
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	};
stop_process:
}
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
