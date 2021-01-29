#define TestMergesharding_shard_Vttablets  1
#define not_found_{shard0shard1}47824  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example607227872/go/test/endtoend/sharding/mergesharding/mergesharding_base.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int shard_Vttablets = TestMergesharding_shard_Vttablets;
	run wgMonitor(wg);
		for(i : 0.. not_found_{shard0shard1}47824-1) {
		for50: skip;
				for(i : 0.. shard_Vttablets-1) {
			for51: skip;
			wg.Add!1;
			run go_Anonymous0(wg);
			for51_end: skip
		};
		for51_exit: skip;
		for50_end: skip
	};
	for50_exit: skip;
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

