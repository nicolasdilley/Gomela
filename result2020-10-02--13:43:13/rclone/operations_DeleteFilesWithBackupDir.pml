
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example822197482/fs/operations/operations.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int fs_Config_Transfers = 5;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!fs_Config_Transfers;
		for(i : 0.. fs_Config_Transfers-1) {
for10:		run Anonymous0(wg)
	};
for10_exit:	wg.Wait?0;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
		for(i : 1.. toBeDeleted) {
for11:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	};
	wg.Add!-1;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
