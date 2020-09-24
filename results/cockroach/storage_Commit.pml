#define lb_for1665_0  -1
#define ub_for1665_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example167378074/pkg/storage/rocksdb.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int pending = 5;
	int merge = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: lb_for1665_0 != -1 && ub_for1665_1 != -1 -> 
						for(i : lb_for1665_0.. ub_for1665_1) {
for10:
			}
		:: else -> 
			do
			:: true -> 
for10:
			:: true -> 
				break
			od
		fi;
for10_exit:		Wgdef committer_commitWG;
		run wgMonitor(committer_commitWG);
		
		if
		:: true -> 
			Wgdef committer_commitWG;
			run wgMonitor(committer_commitWG)
		:: true;
		fi;
		do
		:: true -> 
for20:			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od;
		do
		:: true -> 
for30:
		:: true -> 
			break
		od
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
