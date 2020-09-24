#define lb_for966_0  -1
#define ub_for966_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example131909709/go/kbfs/libkbfs/md_util.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int items = 5;
	int rmd_data_Changes_Ops = 5;
	Wgdef fbo_doneWg;
	int chain_ops = 5;
	bool state = false;
	int rmds = 5;
	int chains_byMostRecent = 5;
	int itemSlice = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(fbo_doneWg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for30:		do
		:: true -> 
for31:			
			if
			:: true -> 
				
				if
				:: lb_for966_0 != -1 && ub_for966_1 != -1 -> 
										for(i : lb_for966_0.. ub_for966_1) {
for32:						
						if
						:: true -> 
							do
							:: true -> 
for33:								
								if
								:: true -> 
									break
								:: true;
								fi
							:: true -> 
								break
							od
						:: true;
						fi;
						
						if
						:: true -> 
							break
						:: true;
						fi;
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					}
				:: else -> 
					do
					:: true -> 
for32:						
						if
						:: true -> 
							do
							:: true -> 
for33:								
								if
								:: true -> 
									break
								:: true;
								fi
							:: true -> 
								break
							od
						:: true;
						fi;
						
						if
						:: true -> 
							break
						:: true;
						fi;
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					:: true -> 
						break
					od
				fi;
for32_exit:
			:: true;
			fi
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
	do
	:: true -> 
for40:
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
