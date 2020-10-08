#define lb_for56_0  -1
#define ub_for56_1  -1
#define lb_for28_2  -1
#define ub_for28_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example927266388/flow/dataset_run.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int d_Shards = 5;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: true -> 
		chan child_dconnectExternalInputChansToRead0 = [0] of {int};
		run dconnectExternalInputChansToRead(wg,child_dconnectExternalInputChansToRead0);
		child_dconnectExternalInputChansToRead0?0;
				for(i : 1.. d_Shards) {
for20:
		}
	:: true -> 
				for(i : 1.. d_Shards) {
for30:			wg.Add!1;
			run Anonymous2(wg)
		}
	:: true -> 
				for(i : 1.. d_Shards) {
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
		for(i : 1.. d_ExternalInputChans) {
for10:		wg.Add!1;
		run Anonymous1()
	};
	child!0;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	
	if
	:: lb_for56_0 != -1 && ub_for56_1 != -1 -> 
				for(i : lb_for56_0.. ub_for56_1) {
for11:			
			if
			:: true -> 
								for(i : 1.. d_Shards) {
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
								for(i : 1.. d_Shards) {
for12:
				}
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for11_exit:		for(i : 1.. d_Shards) {
for13:
	};
stop_process:
}
proctype Anonymous2(Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: lb_for28_2 != -1 && ub_for28_3 != -1 -> 
				for(i : lb_for28_2.. ub_for28_3) {
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
for31_exit:	wg.Add!-1;
stop_process:
}
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
