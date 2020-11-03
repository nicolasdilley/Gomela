#define refreshTabletsUsing_cells 0
#define refreshTabletsUsing_inputs 0
#define refreshTabletsUsing_shards 0
#define refreshTabletsUsing_keyspaceShards 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example345111863/go/vt/orchestrator/logic/tablet_discovery.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int inputs = refreshTabletsUsing_inputs;
	bool state = false;
	int keyspaceShards = refreshTabletsUsing_keyspaceShards;
	int cells = refreshTabletsUsing_cells;
	int shards = refreshTabletsUsing_shards;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 0.. cells-1) {
for10:			wg.Add!1;
			run Anonymous0(wg,wg)
		};
		wg.Wait?0
	:: true -> 
				for(i : 0.. inputs-1) {
for20:			
			if
			:: true -> 
								for(i : 0.. shards-1) {
for21:
				}
			:: true -> 
								for(i : 0.. shards-1) {
for21:
				}
			fi
		};
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. keyspaceShards-1) {
for30:			wg.Add!1;
			run Anonymous1(wg,wg)
		};
		wg.Wait?0
	:: true -> 
				for(i : 0.. inputs-1) {
for20:			
			if
			:: true -> 
								for(i : 0.. shards-1) {
for21:
				}
			:: true -> 
								for(i : 0.. shards-1) {
for21:
				}
			fi
		};
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. keyspaceShards-1) {
for30:			wg.Add!1;
			run Anonymous1(wg,wg)
		};
		wg.Wait?0
	fi
stop_process:}

proctype Anonymous0(Wgdef wg;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
}
proctype Anonymous1(Wgdef wg;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
}
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

