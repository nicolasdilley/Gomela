#define DeleteFilesWithBackupDir_fs_Config_Transfers  5
#define DeleteFilesWithBackupDir_toBeDeleted  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example032656846/fs/operations/operations.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int fs_Config_Transfers = DeleteFilesWithBackupDir_fs_Config_Transfers;
	Wgdef wg;
	int toBeDeleted = DeleteFilesWithBackupDir_toBeDeleted;
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
	bool state;
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
