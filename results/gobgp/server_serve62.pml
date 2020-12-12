#define serve_l  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example084311334/pkg/server/grpc_server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int l = serve_l;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: true -> 
				for(i : 0.. l-1) {
for20:
		};
		goto stop_process
	:: true;
	fi;
	wg.Add!l;
	wg.Wait?0;
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
	od
}
