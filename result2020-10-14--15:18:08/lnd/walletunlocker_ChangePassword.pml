#define ChangePassword_u_macaroonFiles  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example653067025/walletunlocker/service.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int u_macaroonFiles = ChangePassword_u_macaroonFiles;
	Wgdef w_wg;
	int i;
	
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
	run wgMonitor(w_wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. u_macaroonFiles) {
for10:		
		if
		:: true -> 
			goto stop_process
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
