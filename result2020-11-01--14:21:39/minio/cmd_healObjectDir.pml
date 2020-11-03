#define healObjectDir_storageDisks 1
#define healObjectDir_errs 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example320658119/cmd/erasure-healing.go
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
						for(i : 0.. storageDisks-1) {
for10:				wg.Add!1;
				run Anonymous0(wg)
			};
			wg.Wait?0
		:: true;
		fi
	:: true;
	fi;
		for(i : 0.. errs-1) {
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
		for(i : 0.. errs-1) {
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

