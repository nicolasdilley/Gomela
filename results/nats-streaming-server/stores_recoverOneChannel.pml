
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example429967708/stores/filestore.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int subStore_subs = 5;
	Wgdef msgStore_allDone;
	int i;
	Wgdef subStore_allDone;
	int sub_seqnos = 5;
	bool state = false;
	run wgMonitor(msgStore_allDone);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(subStore_allDone);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			do
			:: true -> 
for11:
			:: true -> 
				break
			od
		:: true;
		fi
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		do
		:: true;
		:: true -> 
			break
		od
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
