#define runEncryptionStatus_fileRegistry_Files  60
#define runEncryptionStatus_keyRegistry_DataKeys  60
#define runEncryptionStatus_keyRegistry_StoreKeys  60
#define runEncryptionStatus_storeKeyList  60
#define runEncryptionStatus_children  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example543475193/pkg/ccl/cliccl/debug.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef stopper_stop;
	int storeKeyList = runEncryptionStatus_storeKeyList;
	int keyRegistry_DataKeys = runEncryptionStatus_keyRegistry_DataKeys;
	int i;
	int fileRegistry_Files = runEncryptionStatus_fileRegistry_Files;
	int keyRegistry_StoreKeys = runEncryptionStatus_keyRegistry_StoreKeys;
	int children = runEncryptionStatus_children;
	bool state = false;
	run wgMonitor(stopper_stop);
	
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
		for(i : 1.. fileRegistry_Files) {
for10:
	};
		for(i : 1.. keyRegistry_DataKeys) {
for20:
	};
		for(i : 1.. keyRegistry_StoreKeys) {
for30:
	};
		for(i : 1.. storeKeyList) {
for40:		
		if
		:: true -> 
						for(i : 1.. children) {
for41:
			}
		:: true;
		fi
	};
	
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
	od;
stop_process:
}
