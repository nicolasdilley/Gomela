
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example342749208/kernel.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef writersWG;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(writersWG);
	writersWG.Add!2;
	run go_Anonymous0(writersWG);
	run go_Anonymous1(writersWG);
	writersWG.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef writersWG) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	writersWG.Add!-1
}
proctype go_Anonymous1(Wgdef writersWG) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	writersWG.Add!-1
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

