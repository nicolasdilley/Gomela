
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example947739188/session.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int info_request_pkeyColumns = 5;
	bool state = false;
	int info_request_columns = 5;
	Wgdef inflight_wg;
	int partitionKey = 5;
	int i;
	
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
	run wgMonitor(inflight_wg);
	inflight_wg.Add!1;
	
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
				for(i : 1.. info_request_pkeyColumns) {
for10:
		};
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
		for(i : 1.. partitionKey) {
for20:				for(i : 1.. info_request_columns) {
for21:			
			if
			:: true -> 
				break
			:: true;
			fi
		};
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	goto stop_process;
	inflight_wg.Add!-1
stop_process:}

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