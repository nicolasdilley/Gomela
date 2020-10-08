
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example672862733/pkg/sql/catalog/lease/lease.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int ids = 5;
	Wgdef wg;
	bool state = false;
	int m_mu_descriptors = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. m_mu_descriptors) {
for10:		
		if
		:: true -> 
			break
		:: true;
		fi
	};
	run wgMonitor(wg);
		for(i : 1.. ids) {
for20:		wg.Add!1;
		
		if
		:: true -> 
			wg.Add!-1
		:: true;
		fi
	};
	wg.Wait?0
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
