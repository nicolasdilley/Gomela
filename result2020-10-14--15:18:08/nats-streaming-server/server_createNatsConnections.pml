
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example980510934/server/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef s_ncs_wg;
	bool state = false;
	run wgMonitor(s_ncs_wg);
	
	if
	:: true -> 
		Wgdef s_nc_wg;
		run wgMonitor(s_nc_wg)
	:: true;
	fi;
	
	if
	:: true -> 
		Wgdef s_nca_wg;
		run wgMonitor(s_nca_wg)
	:: true;
	fi;
	
	if
	:: true -> 
		Wgdef s_ftnc_wg;
		run wgMonitor(s_ftnc_wg)
	:: true;
	fi;
	
	if
	:: true -> 
		Wgdef s_ncr_wg;
		run wgMonitor(s_ncr_wg);
		
		if
		:: true -> 
			Wgdef s_ncsr_wg;
			run wgMonitor(s_ncsr_wg)
		:: true;
		fi
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
