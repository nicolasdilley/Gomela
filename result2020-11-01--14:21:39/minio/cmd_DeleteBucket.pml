#define DeleteBucket_s_sets 3
#define DeleteBucket_errs 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example320658119/cmd/erasure-sets.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int s_sets = DeleteBucket_s_sets;
	Wgdef g_wg;
	int errs = DeleteBucket_errs;
	bool state = false;
	run wgMonitor(g_wg);
		for(i : 0.. s_sets-1) {
for10:
	};
		for(i : 0.. errs-1) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

