#define ServerInfoHandler_servers 3
#define ServerInfoHandler_storageInfo_Disks 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example320658119/cmd/admin-handlers.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int storageInfo_Disks = ServerInfoHandler_storageInfo_Disks;
	int servers = ServerInfoHandler_servers;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		Wgdef ldapConn_wgClose;
		run wgMonitor(ldapConn_wgClose)
	:: true;
	fi;
		for(i : 0.. servers-1) {
for10:				for(i : 0.. storageInfo_Disks-1) {
for11:
		}
	};
		for(i : 0.. storageInfo_Disks-1) {
for20:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi
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

