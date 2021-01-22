
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example782087560/tcpip/transport/tcp/accept.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef n_pendingAccepted;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(n_pendingAccepted);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi
stop_process:skip
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

