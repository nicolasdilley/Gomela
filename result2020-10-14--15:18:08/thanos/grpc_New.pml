#define New_opts  60
#define New_options_registerServerFuncs  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example526373364/pkg/server/grpc/grpc.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int options_registerServerFuncs = New_options_registerServerFuncs;
	Wgdef s_serveWG;
	bool state = false;
	int opts = New_opts;
	int i;
		for(i : 1.. opts) {
for10:
	};
	run wgMonitor(s_serveWG);
		for(i : 1.. options_registerServerFuncs) {
for20:
	};
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
