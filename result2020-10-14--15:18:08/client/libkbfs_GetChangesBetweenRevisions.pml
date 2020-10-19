#define GetChangesBetweenRevisions_rmds  60
#define GetChangesBetweenRevisions_rmd_data_Changes_Ops  60
#define GetChangesBetweenRevisions_chains_byMostRecent  60
#define GetChangesBetweenRevisions_chain_ops  60
#define GetChangesBetweenRevisions_itemSlice  60
#define GetChangesBetweenRevisions_items  60
#define lb_for966_6  -1
#define ub_for966_7  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example695274255/go/kbfs/libkbfs/md_util.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int items = GetChangesBetweenRevisions_items;
	int rmd_data_Changes_Ops = GetChangesBetweenRevisions_rmd_data_Changes_Ops;
	Wgdef fbo_doneWg;
	int chain_ops = GetChangesBetweenRevisions_chain_ops;
	bool state = false;
	int rmds = GetChangesBetweenRevisions_rmds;
	int chains_byMostRecent = GetChangesBetweenRevisions_chains_byMostRecent;
	int itemSlice = GetChangesBetweenRevisions_itemSlice;
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
		for(i : 1.. rmds) {
for10:
	};
		for(i : 1.. rmds) {
for20:				for(i : 1.. rmd_data_Changes_Ops) {
for21:
		}
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. chains_byMostRecent) {
for30:				for(i : 1.. chain_ops) {
for31:			
			if
			:: true -> 
				
				if
				:: lb_for966_6 != -1 && ub_for966_7 != -1 -> 
										for(i : lb_for966_6.. ub_for966_7) {
for32:						
						if
						:: true -> 
														for(i : 1.. itemSlice) {
for33:								
								if
								:: true -> 
									break
								:: true;
								fi
							}
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
														for(i : 1.. itemSlice) {
for33:								
								if
								:: true -> 
									break
								:: true;
								fi
							}
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
		}
	};
		for(i : 1.. items) {
for40:
	};
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
