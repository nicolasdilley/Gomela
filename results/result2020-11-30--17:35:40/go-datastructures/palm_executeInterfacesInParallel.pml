#define executeInterfacesInParallel_int1879  0
#define executeInterfacesInParallel_numCPU  1
#define executeInterfacesInParallel_uint6418911  1
#define lb_for193_3  -1
#define ub_for193_4  -1

// /tmp/clone-example207091617/btree/palm/action.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int int1879 = executeInterfacesInParallel_int1879;
	bool state = false;
	int uint6418911 = executeInterfacesInParallel_uint6418911;
	Wgdef wg;
	int numCPU = executeInterfacesInParallel_numCPU;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	wg.Add!int1879;
for10_exit:	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for11:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for11_exit:stop_process:	wg.Add!-1
}
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
	od
}
