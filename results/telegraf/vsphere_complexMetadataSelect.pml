
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example628089191/plugins/inputs/vsphere/endpoint.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef te_wg;
	int mMap = 5;
	int sampledObjects = 5;
	bool state = false;
	int maxMetadataSamples = 5;
	int metrics = 5;
	int i;
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		
		if
		:: 0 != -1 && maxMetadataSamples-1 != -1 -> 
						for(i : 0.. maxMetadataSamples-1) {
for20:
			}
		:: else -> 
			do
			:: true -> 
for20:
			:: true -> 
				break
			od
		fi;
for20_exit:
	:: true;
	fi;
	run wgMonitor(te_wg);
	do
	:: true -> 
for30:
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
