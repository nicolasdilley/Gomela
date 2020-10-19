#define TestResharding_clusterInstance_Keyspaces[0]_Shards  60
#define TestResharding_shard_Vttablets  60
#define TestResharding_mysqlCtlProcessList  60
#define TestResharding_keyspace_Shards  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example994420206/go/test/endtoend/sharding/resharding/resharding_base.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int keyspace_Shards = TestResharding_keyspace_Shards;
	int shard_Vttablets = TestResharding_shard_Vttablets;
	bool state = false;
	int clusterInstance_Keyspaces[0]_Shards = TestResharding_clusterInstance_Keyspaces[0]_Shards;
	int mysqlCtlProcessList = TestResharding_mysqlCtlProcessList;
	int i;
		for(i : 1.. clusterInstance_Keyspaces[0]_Shards) {
for10:				for(i : 1.. shard_Vttablets) {
for11:
		}
	};
		for(i : 1.. mysqlCtlProcessList) {
for20:
	};
		for(i : 1.. clusterInstance_Keyspaces[0]_Shards) {
for30:				for(i : 1.. shard_Vttablets) {
for31:
		}
	};
		for(i : 1.. keyspace_Shards) {
for40:				for(i : 1.. shard_Vttablets) {
for41:
		}
	};
	do
	:: true -> 
for50:
	:: true -> 
		break
	od;
	run wgMonitor(wg);
		for(i : 1.. 5) {
for60:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
	do
	:: true -> 
for70:
	:: true -> 
		break
	od
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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
