#define Remove_sortedPendingMsgs 3
#define Remove_qsubs 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example040657727/server/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef s_ioChannelWG;
	bool state = false;
	int qsubs = Remove_qsubs;
	Wgdef s_wg;
	int sortedPendingMsgs = Remove_sortedPendingMsgs;
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
								for(i : 0.. sortedPendingMsgs-1) {
for10:
				}
			:: true;
			fi
		:: true -> 
			
			if
			:: true -> 
								for(i : 0.. sortedPendingMsgs-1) {
for10:
				}
			:: true;
			fi
		fi
	fi;
	
	if
	:: true -> 
				for(i : 0.. qsubs-1) {
for20:
		}
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

