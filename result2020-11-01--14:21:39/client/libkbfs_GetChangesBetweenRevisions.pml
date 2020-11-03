#define GetChangesBetweenRevisions_rmds  ??
#define GetChangesBetweenRevisions_rmd_data_Changes_Ops  ??
#define GetChangesBetweenRevisions_chains_byMostRecent  ??
#define GetChangesBetweenRevisions_chain_ops  ??
#define GetChangesBetweenRevisions_itemSlice  ??
#define GetChangesBetweenRevisions_items  ??
#define lb_for966_6  -1
#define ub_for966_7  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example441703692/go/kbfs/libkbfs/md_util.go
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
		for(i : 0.. rmds-1) {
for10:
	};
		for(i : 0.. rmds-1) {
for20:				for(i : 0.. rmd_data_Changes_Ops-1) {
for21:
		}
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. chains_byMostRecent-1) {
for30:				for(i : 0.. chain_ops-1) {
for31:			
			if
			:: true -> 
				
				if
				:: lb_for966_6 != -1 && ub_for966_7 != -1 -> 
										for(i : lb_for966_6.. ub_for966_7) {
for32:						
						if
						:: true -> 
														for(i : 0.. itemSlice-1) {
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
														for(i : 0.. itemSlice-1) {
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
		for(i : 0.. items-1) {
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
	od
}
