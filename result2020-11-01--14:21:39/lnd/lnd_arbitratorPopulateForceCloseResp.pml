#define arbitratorPopulateForceCloseResp_reports 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example581033907/rpcserver.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef arbitrator_wg;
	int i;
	int reports = arbitratorPopulateForceCloseResp_reports;
	bool state = false;
	run wgMonitor(arbitrator_wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. reports-1) {
for10:		

		if
		:: true;
		:: true -> 
			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			

			if
			:: true;
			:: true;
			:: true;
			fi
		:: true -> 
			goto stop_process
		fi
	};
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

