#define ApplyChanges_allChanges  60
#define ApplyChanges_zonesChangeUniques  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example085448875/provider/ovh/ovh.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int zonesChangeUniques = ApplyChanges_zonesChangeUniques;
	Wgdef eg_wg;
	bool state = false;
	int allChanges = ApplyChanges_allChanges;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(eg_wg);
		for(i : 1.. allChanges) {
for10:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. zonesChangeUniques) {
for20:
	};
	
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
