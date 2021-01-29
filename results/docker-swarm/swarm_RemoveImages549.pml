#define RemoveImages_c_listActiveEngines55420  1
#define RemoveImages_e_Images55525  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example049650158/cluster/swarm/cluster.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int e_Images55525 = RemoveImages_e_Images55525;
	int c_listActiveEngines55420 = RemoveImages_c_listActiveEngines55420;
	run wgMonitor(wg);
		for(i : 0.. c_listActiveEngines55420-1) {
		for10: skip;
				for(i : 0.. e_Images55525-1) {
			for11: skip;
			

			if
			:: true -> 
				wg.Add!1;
				run go_Anonymous0(wg)
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip;
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

