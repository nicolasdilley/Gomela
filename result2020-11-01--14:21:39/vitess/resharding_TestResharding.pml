#define TestResharding_clusterInstance_Keyspaces[0]_Shards 3
#define TestResharding_shard_Vttablets 3
#define TestResharding_mysqlCtlProcessList 3
#define TestResharding_keyspace_Shards 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example345111863/go/test/endtoend/sharding/resharding/resharding_base.go
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
		for(i : 0.. clusterInstance_Keyspaces[0]_Shards-1) {
for10:				for(i : 0.. shard_Vttablets-1) {
for11:
		}
	};
		for(i : 0.. mysqlCtlProcessList-1) {
for20:
	};
		for(i : 0.. clusterInstance_Keyspaces[0]_Shards-1) {
for30:				for(i : 0.. shard_Vttablets-1) {
for31:
		}
	};
		for(i : 0.. keyspace_Shards-1) {
for40:				for(i : 0.. shard_Vttablets-1) {
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
		for(i : 0.. 5-1) {
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

