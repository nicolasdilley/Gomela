#define shard_Vttablets  5
#define 2  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example669713740/go/test/endtoend/sharding/mergesharding/mergesharding_base.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int keyspace_Shards = 5;
	int shard_Vttablets = 5;
	bool state = false;
	int clusterInstance_Keyspaces[0]_Shards = 5;
	int mysqlCtlProcessList = 5;
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
for11:
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
	do
	:: true -> 
for20:
	:: true -> 
		break
	od;
	do
	:: true -> 
for30:		do
		:: true -> 
for31:
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
	do
	:: true -> 
for40:		do
		:: true -> 
for41:
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
	run wgMonitor(wg);
		for(i : 1.. 2) {
for50:				for(i : 1.. shard_Vttablets) {
for51:			wg.Add!1;
			run Anonymous0(wg)
		}
	};
	wg.Wait?0;
	do
	:: true -> 
for60:
	:: true -> 
		break
	od;
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
	wg.Add!-1;
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
