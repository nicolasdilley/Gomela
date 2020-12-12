#define RunDatasetInStandAloneMode_d_Shards  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example089788934/flow/dataset_run.go
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
		chan child_connectExternalInputChansToRead0 = [0] of {int};
		run connectExternalInputChansToRead(wg,child_connectExternalInputChansToRead0);
		child_connectExternalInputChansToRead0?0;
				for(i : 0.. d_Shards-1) {
for20:
		}
	:: true -> 
				for(i : 0.. d_Shards-1) {
for30:			wg.Add!1;
			run Anonymous1(wg)
		}
	:: true -> 
				for(i : 0.. d_Shards-1) {
for30:			wg.Add!1;
			run Anonymous1(wg)
		}
	fi;
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype connectExternalInputChansToRead(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int d_ExternalInputChans = ??;
stop_process:	child!0
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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
