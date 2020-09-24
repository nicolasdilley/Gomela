
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example391587469/functional/tester/stresser.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef ks_wg;
	int i;
	int clus_Tester_Stressers = 5;
	bool state = false;
	run wgMonitor(ks_wg);
	do
	:: true -> 
for10:		

		if
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		fi
	:: true -> 
		break
	od;
	
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
