#define ub_for22_2  3

// https://github.com/nsqio/nsq/blob/master/internal/protocol/tcp_server.go#L17
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TCPServer170 = [1] of {int};
	run TCPServer17(child_TCPServer170)
stop_process:skip
}

proctype TCPServer17(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTCPServer38200 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. ub_for22_2) {
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: true;
		fi;
		wg.update!1;
		run AnonymousTCPServer3820(wg,child_AnonymousTCPServer38200);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTCPServer3820(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

