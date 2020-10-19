#define removeRemoteSubs_subs  60
#define removeRemoteSubs_as  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example507681897/server/route.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int subs = removeRemoteSubs_subs;
	Wgdef srv_grWG;
	int as = removeRemoteSubs_as;
	bool state = false;
	run wgMonitor(srv_grWG);
		for(i : 1.. subs) {
for10:
	};
		for(i : 1.. as) {
for20:
	}
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
	od;
stop_process:
}
