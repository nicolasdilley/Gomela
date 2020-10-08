
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example366925241/btree/immutable/query.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int chunks = 5;
	bool state = false;
	int result = 5;
	Wgdef wg;
	int chunk = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. keys) {
for10:
	};
	run wgMonitor(wg);
	wg.Add!chunks;
		for(i : 0.. chunks-1) {
for20:		run Anonymous0(wg)
	};
for20_exit:	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. result) {
for30:
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
		for(i : 1.. chunk) {
for21:		
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
