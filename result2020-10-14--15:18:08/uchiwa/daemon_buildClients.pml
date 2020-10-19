#define buildClients_d_Data_Clients  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example791345209/uchiwa/daemon/clients.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int d_Data_Clients = buildClients_d_Data_Clients;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. d_Data_Clients) {
for10:		wg.Add!1;
		run go_dbuildClient(wg)
	};
	wg.Wait?0
stop_process:}

proctype go_dbuildClient(Wgdef wg) {
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
