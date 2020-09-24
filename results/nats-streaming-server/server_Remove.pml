
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example429967708/server/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef s_ioChannelWG;
	bool state = false;
	int qsubs = 5;
	Wgdef s_wg;
	int sortedPendingMsgs = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(s_wg);
	run wgMonitor(s_ioChannelWG);
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				do
				:: true -> 
for10:
				:: true -> 
					break
				od
			:: true;
			fi
		:: true -> 
			
			if
			:: true -> 
				do
				:: true -> 
for10:
				:: true -> 
					break
				od
			:: true;
			fi
		fi
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for20:
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
