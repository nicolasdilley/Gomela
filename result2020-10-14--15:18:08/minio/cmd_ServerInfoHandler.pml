#define ServerInfoHandler_servers  60
#define ServerInfoHandler_storageInfo_Disks  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example604607877/cmd/admin-handlers.go
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
		for(i : 1.. servers) {
for10:				for(i : 1.. storageInfo_Disks) {
for11:
		}
	};
		for(i : 1.. storageInfo_Disks) {
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
	od;
stop_process:
}
