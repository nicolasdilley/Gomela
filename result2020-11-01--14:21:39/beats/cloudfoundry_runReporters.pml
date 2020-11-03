
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example443653905/x-pack/metricbeat/module/cloudfoundry/v2.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		Wgdef m_listener_wg;
		run wgMonitor(m_listener_wg)
	:: true;
	fi;
	
	if
	:: true -> 
		Wgdef l_wg;
		run wgMonitor(l_wg);
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
