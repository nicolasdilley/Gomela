#define ValidateParams_rd_externalImportList40621  3

// /tmp/clone-example806521426/gps/solver.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef deducePkgsGroup;
	int i;
	int rd_externalImportList40621 = ValidateParams_rd_externalImportList40621;
	bool state = false;
	run wgMonitor(deducePkgsGroup);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. rd_externalImportList40621-1) {
for10:		deducePkgsGroup.Add!1
	};
	deducePkgsGroup.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
