#define deleteAll_z_serverPools  3
#define deleteAll_servers_sets  1
#define deleteAll_set_getDisks108625  1

// https://github.com/minio/minio/blob/3163a660aa79b75b725a0c6f152557e6253b900f/cmd/erasure-server-pool.go#L1082
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int set_getDisks108625 = deleteAll_set_getDisks108625;
	int servers_sets = deleteAll_servers_sets;
	int z_serverPools = deleteAll_z_serverPools;
	run wgMonitor(wg);
		for(i : 0.. z_serverPools-1) {
		for10: skip;
				for(i : 0.. servers_sets-1) {
			for11: skip;
						for(i : 0.. set_getDisks108625-1) {
				for12: skip;
				

				if
				:: true -> 
					goto for12_end
				:: true;
				fi;
				wg.Add!1;
				run go_Anonymous0(wg);
				for12_end: skip
			};
			for12_exit: skip;
			for11_end: skip
		};
		for11_exit: skip;
		for10_end: skip
	};
	for10_exit: skip;
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

