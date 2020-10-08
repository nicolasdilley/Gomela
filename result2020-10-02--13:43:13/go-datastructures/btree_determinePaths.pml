
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example366925241/btree/immutable/add.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int chunkPaths = 5;
	Wgdef wg;
	int i;
	int chunks = 5;
	int chunk = 5;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!chunks;
		for(i : 1.. chunks) {
for10:		run Anonymous0(wg)
	};
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. chunkPaths) {
for20:				for(i : 1.. chunk) {
for21:
		}
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. keys) {
for11:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	wg.Add!-1;
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
