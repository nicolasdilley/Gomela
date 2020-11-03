#define FindAllTargets_ksNames 3
#define FindAllTargets_ks_Partitions 3
#define FindAllTargets_tabletTypes 0
#define FindAllTargets_ksPartition_ShardReferences 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example345111863/go/vt/srvtopo/discover.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int ksPartition_ShardReferences = FindAllTargets_ksPartition_ShardReferences;
	int ks_Partitions = FindAllTargets_ks_Partitions;
	bool state = false;
	int ksNames = FindAllTargets_ksNames;
	int tabletTypes = FindAllTargets_tabletTypes;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. ksNames-1) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. ks_Partitions-1) {
for11:				for(i : 0.. tabletTypes-1) {
for12:
		};
				for(i : 0.. ksPartition_ShardReferences-1) {
for13:
		}
	};
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

