
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example588687874/modules/http_proxy/http_proxy_base_hosttracker.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef _Resolved;
	int i;
	Wgdef _Resolved;
	bool state = false;
	run wgMonitor(_Resolved);
	run wgMonitor(_Resolved)
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
