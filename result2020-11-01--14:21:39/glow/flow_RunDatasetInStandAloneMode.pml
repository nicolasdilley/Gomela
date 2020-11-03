#define RunDatasetInStandAloneMode_d_Shards 3
#define lb_for56_1  -1
#define ub_for56_2  -1
#define lb_for28_3  -1
#define ub_for28_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example682710139/flow/dataset_run.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int d_Shards = RunDatasetInStandAloneMode_d_Shards;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: true -> 
		chan child_dconnectExternalInputChansToRead0 = [0] of {int};
		run dconnectExternalInputChansToRead(wg,child_dconnectExternalInputChansToRead0);
		child_dconnectExternalInputChansToRead0?0;
				for(i : 0.. d_Shards-1) {
for20:
		}
	:: true -> 
				for(i : 0.. d_Shards-1) {
for30:			wg.Add!1;
			run Anonymous2(wg)
		}
	:: true -> 
				for(i : 0.. d_Shards-1) {
for30:			wg.Add!1;
			run Anonymous2(wg)
		}
	fi;
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype dconnectExternalInputChansToRead(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
		for(i : 0.. d_ExternalInputChans-1) {
for10:		wg.Add!1;
		run Anonymous1()
	};
stop_process:	child!0
}
proctype Anonymous1() {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for56_1 != -1 && ub_for56_2 != -1 -> 
				for(i : lb_for56_1.. ub_for56_2) {
for11:			
			if
			:: true -> 
								for(i : 0.. d_Shards-1) {
for12:
				}
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for11:			
			if
			:: true -> 
								for(i : 0.. d_Shards-1) {
for12:
				}
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for11_exit:		for(i : 0.. d_Shards-1) {
for13:
	};
stop_process:
}
proctype Anonymous2(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for28_3 != -1 && ub_for28_4 != -1 -> 
				for(i : lb_for28_3.. ub_for28_4) {
for31:
		}
	:: else -> 
		do
		:: true -> 
for31:
		:: true -> 
			break
		od
	fi;
for31_exit:stop_process:	wg.Add!-1
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

