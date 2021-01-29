#define not_found_{shard1Mastershard1Replica1shard1Replica2shard1Rdonlyshard1RdonlyZ2}92225  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example607227872/go/test/endtoend/sharding/resharding/resharding_base.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(wg);
		for(i : 0.. not_found_{shard1Mastershard1Replica1shard1Replica2shard1Rdonlyshard1RdonlyZ2}92225-1) {
		for60: skip;
		wg.Add!1;
		run go_Anonymous0(wg);
		for60_end: skip
	};
	for60_exit: skip;
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

