
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example596577888/server/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef s_ncsr_wg;
	Wgdef s_ncr_wg;
	Wgdef s_ftnc_wg;
	Wgdef s_nca_wg;
	Wgdef s_nc_wg;
	Wgdef s_ncs_wg;
	bool state = false;
	int i;
	run wgMonitor(s_ncs_wg);
	

	if
	:: true -> 
		run wgMonitor(s_nc_wg)
	:: true;
	fi;
	

	if
	:: true -> 
		run wgMonitor(s_nca_wg)
	:: true;
	fi;
	

	if
	:: true -> 
		run wgMonitor(s_ftnc_wg)
	:: true;
	fi;
	

	if
	:: true -> 
		run wgMonitor(s_ncr_wg);
		

		if
		:: true -> 
			run wgMonitor(s_ncsr_wg)
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:skip
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

