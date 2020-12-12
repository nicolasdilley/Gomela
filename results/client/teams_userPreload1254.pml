#define userPreload_uidSet  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example678508291/go/teams/loader.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int uidSet = userPreload_uidSet;
	int links = -2;
	int i;
	
	if
	:: true -> 
				for(i : 0.. links-1) {
for10:
		};
		
		if
		:: true -> 
			Wgdef wg;
			run wgMonitor(wg);
						for(i : 0.. uidSet-1) {
for20:				wg.Add!1;
				run Anonymous0(wg)
			};
			
			if
			:: true -> 
				wg.Wait?0
			:: true;
			fi
		:: true -> 
						for(i : 0.. uidSet-1) {
for30:
			}
		:: true -> 
						for(i : 0.. uidSet-1) {
for30:
			}
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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
	od
}
