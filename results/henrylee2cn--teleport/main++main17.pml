#define main_loop  1
#define main_group  1

// https://github.com/henrylee2cn/teleport/blob/b23c46ba9ee6cb8ede9b6e09c525784bb096ba27/socket/example/socket_client_ab.go#L17
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef count;
	int num_msgs = 0;
	bool state = false;
	int i;
	int group = main_group;
	int loop = main_loop;
	run wgMonitor(count);
		for(i : 0.. loop-1) {
		for10: skip;
		count.Add!group;
				for(i : 0.. group-1) {
			for11: skip;
			run go_Anonymous0(count);
			for11_end: skip
		};
		for11_exit: skip;
		count.Wait?0;
		for10_end: skip
	};
	for10_exit: skip
stop_process:skip
}

proctype go_Anonymous0(Wgdef count) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	count.Add!-1
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

