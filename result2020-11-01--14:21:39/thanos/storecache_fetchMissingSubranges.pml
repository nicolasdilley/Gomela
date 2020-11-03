#define fetchMissingSubranges_missing 3
#define lb_for399_1  -1
#define ub_for399_2  -1
#define lb_for407_3  -1
#define ub_for407_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example011830901/pkg/store/cache/caching_bucket.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int missing = fetchMissingSubranges_missing;
	Wgdef g_wg;
	int i;
	
	if
	:: lb_for399_1 != -1 && ub_for399_2 != -1 -> 
				for(i : lb_for399_1.. ub_for399_2) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: lb_for407_3 != -1 && ub_for407_4 != -1 -> 
				for(i : lb_for407_3.. ub_for407_4) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:	run wgMonitor(g_wg);
		for(i : 0.. missing-1) {
for30:
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

