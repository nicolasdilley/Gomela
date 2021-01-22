#define tcpConnScan_s_maxPort  0
#define tcpConnScan_s_minPort  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example719622462/scan/scan.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int s_minPort = tcpConnScan_s_minPort;
	int s_maxPort = tcpConnScan_s_maxPort;
	run wgMonitor(wg);
		for(i : s_minPort.. s_maxPort) {
		for10: skip;
		wg.Add!1;
		run go_Anonymous0(wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for11: skip;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			wg.Add!-1;
			goto stop_process
		:: true;
		fi;
		break;
		for11_end: skip
	od;
	for11_exit: skip;
	wg.Add!-1;
	stop_process: skip
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

