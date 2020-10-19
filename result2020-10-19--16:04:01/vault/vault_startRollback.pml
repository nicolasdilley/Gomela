#define startRollback_c_mounts_Entries  5
#define startRollback_c_auth_Entries  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example621927734/vault/rollback.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int c_mounts_Entries = startRollback_c_mounts_Entries;
	Wgdef c_rollback_inflightAll;
	int c_auth_Entries = startRollback_c_auth_Entries;
	bool state = false;
	run wgMonitor(c_rollback_inflightAll);
	goto stop_process
stop_process:}

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
	od;
stop_process:
}
