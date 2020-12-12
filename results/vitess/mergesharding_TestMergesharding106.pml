#define TestMergesharding_shard_Vttablets  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example476275474/go/test/endtoend/sharding/mergesharding/mergesharding_base.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int shard_Vttablets = TestMergesharding_shard_Vttablets;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. 2-1) {
for50:				for(i : 0.. shard_Vttablets-1) {
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
