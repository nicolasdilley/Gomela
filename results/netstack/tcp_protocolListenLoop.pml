#define lb_for604_0  -1
#define ub_for604_1  -1
#define lb_for612_2  -1
#define ub_for612_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example152125176/tcpip/transport/tcp/accept.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef ctx_pending;
	int i;
	int maxSegmentsPerWake = 5;
	bool state = false;
	run wgMonitor(ctx_pending);
	do
	:: true -> 
for10:		

		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: lb_for612_2 != -1 && ub_for612_3 != -1 -> 
										for(i : lb_for612_2.. ub_for612_3) {
for11:
					}
				:: else -> 
					do
					:: true -> 
for11:
					:: true -> 
						break
					od
				fi;
for11_exit:
			:: true;
			fi
		:: true -> 
			
			if
			:: 0 != -1 && maxSegmentsPerWake-1 != -1 -> 
								for(i : 0.. maxSegmentsPerWake-1) {
for12:					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for12:					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for12_exit:
		fi
	od;
for10_exit:
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
