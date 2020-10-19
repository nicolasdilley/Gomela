#define healObjectDir_storageDisks  5
#define healObjectDir_errs  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example255495480/cmd/erasure-healing.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int errs = healObjectDir_errs;
	int storageDisks = healObjectDir_storageDisks;
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			Wgdef wg;
			run wgMonitor(wg);
						for(i : 1.. storageDisks) {
for10:				wg.Add!1;
				run Anonymous0(wg)
			};
			wg.Wait?0
		:: true;
		fi
	:: true;
	fi;
		for(i : 1.. errs) {
for20:		

		if
		:: true;
		:: true;
		:: true;
		:: true;
		fi
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. errs) {
for30:		
		if
		:: true -> 
			

			if
			:: true;
			:: true;
			:: true;
			fi
		:: true;
		fi
	};
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
	od;
stop_process:
}
