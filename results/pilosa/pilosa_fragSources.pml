
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example119238356/cluster.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int diff = 5;
	int srcFrags = 5;
	Wgdef srcCluster_wg;
	int tFrags = 5;
	bool state = false;
	int to_nodes = 5;
	int frags = 5;
	int diffs = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
	run wgMonitor(srcCluster_wg);
	
	if
	:: true -> 
		Wgdef srcCluster_wg;
		run wgMonitor(srcCluster_wg)
	:: true;
	fi;
	do
	:: true -> 
for20:		do
		:: true -> 
for21:
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
	do
	:: true -> 
for30:
	:: true -> 
		break
	od;
	do
	:: true -> 
for40:		do
		:: true -> 
for41:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
	goto stop_process
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
