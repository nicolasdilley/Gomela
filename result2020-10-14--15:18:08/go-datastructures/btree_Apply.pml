#define Apply_keys  60
#define Apply_chunks  60
#define Apply_chunk  60
#define Apply_result  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example908394229/btree/immutable/query.go
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
	bool state;
	
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
