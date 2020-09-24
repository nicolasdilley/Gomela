#define lb_for389_0  -1
#define ub_for389_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example429967708/server/snapshot.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef s_ioChannelWG;
	int i;
	int sc_Subscriptions = 5;
	Wgdef s_wg;
	int serverSnap_Channels = 5;
	int channelsBeforeRestore = 5;
	bool state = false;
	run wgMonitor(s_wg);
	run wgMonitor(s_ioChannelWG);
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi;
		
		if
		:: lb_for389_0 != -1 && ub_for389_1 != -1 -> 
						for(i : lb_for389_0.. ub_for389_1) {
for11:				
				if
				:: true -> 
					do
					:: true;
					:: true -> 
						goto stop_process
					od
				fi
			}
		:: else -> 
			do
			:: true -> 
for11:				
				if
				:: true -> 
					do
					:: true;
					:: true -> 
						goto stop_process
					od
				fi
			:: true -> 
				break
			od
		fi;
for11_exit:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
		:: true;
		fi;
		do
		:: true -> 
for12:
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
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
