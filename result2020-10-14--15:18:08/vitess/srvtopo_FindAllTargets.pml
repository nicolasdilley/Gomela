#define FindAllTargets_ksNames  60
#define FindAllTargets_ks_Partitions  60
#define FindAllTargets_tabletTypes  60
#define FindAllTargets_ksPartition_ShardReferences  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example994420206/go/vt/srvtopo/discover.go
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
		for(i : 1.. ksNames) {
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
		for(i : 1.. ks_Partitions) {
for11:				for(i : 1.. tabletTypes) {
for12:
		};
				for(i : 1.. ksPartition_ShardReferences) {
for13:
		}
	};
	wg.Add!-1;
stop_process:
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
	od;
stop_process:
}
