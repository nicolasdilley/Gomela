#define routingKeyInfo_info_request_pkeyColumns  60
#define routingKeyInfo_partitionKey  60
#define routingKeyInfo_info_request_columns  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example994501758/session.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int info_request_columns = routingKeyInfo_info_request_columns;
	int info_request_pkeyColumns = routingKeyInfo_info_request_pkeyColumns;
	bool state = false;
	int partitionKey = routingKeyInfo_partitionKey;
	int i;
	
	if
	:: true -> 
		Wgdef inflight_wg;
		run wgMonitor(inflight_wg);
		inflight_wg.Wait?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
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
