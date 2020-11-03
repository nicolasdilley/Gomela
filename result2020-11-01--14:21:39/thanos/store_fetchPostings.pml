#define fetchPostings_keys 1
#define fetchPostings_parts 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example011830901/pkg/store/bucket.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int parts = fetchPostings_parts;
	Wgdef g_wg;
	bool state = false;
	int keys = fetchPostings_keys;
	int i;
		for(i : 0.. keys-1) {
for10:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	run wgMonitor(g_wg);
		for(i : 0.. parts-1) {
for20:
	};
	goto stop_process
stop_process:}

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

