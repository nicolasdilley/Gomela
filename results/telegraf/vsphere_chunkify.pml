
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example628089191/plugins/inputs/vsphere/endpoint.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int res_metrics = 5;
	Wgdef te_wg;
	int i;
	int res_objects = 5;
	int timeBuckets = 5;
	bool state = false;
	run wgMonitor(te_wg);
	do
	:: true -> 
for10:		do
		:: true -> 
for11:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi
		:: true -> 
			break
		od;
		do
		:: true -> 
for12:
		:: true -> 
			break
		od
	:: true -> 
		break
	od
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
