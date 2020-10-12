
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example668279948/cluster.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
	fi;
	
	if
	:: true -> 
		Wgdef cleaner_Holder_wg;
		run wgMonitor(cleaner_Holder_wg);
		Wgdef cleaner_Cluster_wg;
		run wgMonitor(cleaner_Cluster_wg)
	:: true;
	fi
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