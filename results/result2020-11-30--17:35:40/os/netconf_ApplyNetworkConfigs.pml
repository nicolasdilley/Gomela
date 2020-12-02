#define ApplyNetworkConfigs_links  3

// /tmp/clone-example124431260/pkg/netconf/netconf_linux.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int links = ApplyNetworkConfigs_links;
	Wgdef wg;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. links-1) {
for10:		
		if
		:: true -> 
			chan child_netconfapplyOuter0 = [0] of {int};
			run netconfapplyOuter(wg,child_netconfapplyOuter0);
			child_netconfapplyOuter0?0
		:: true;
		fi
	};
	wg.Wait?0;
		for(i : 0.. links-1) {
for20:		
		if
		:: true -> 
			chan child_netconfapplyOuter1 = [0] of {int};
			run netconfapplyOuter(wg,child_netconfapplyOuter1);
			child_netconfapplyOuter1?0
		:: true;
		fi
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype netconfapplyOuter(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0();
stop_process:	child!0
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
