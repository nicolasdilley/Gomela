#define Apply_keys 3
#define Apply_chunks 1
#define Apply_chunk 0
#define Apply_result 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example401606570/btree/immutable/query.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int result = Apply_result;
	int chunks = Apply_chunks;
	bool state = false;
	int keys = Apply_keys;
	int chunk = Apply_chunk;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. keys-1) {
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
		for(i : 0.. result-1) {
for30:
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. chunk-1) {
for21:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
stop_process:	wg.Add!-1
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
	od
}

