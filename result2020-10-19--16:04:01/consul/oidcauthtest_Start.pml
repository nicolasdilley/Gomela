#define Start_options  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example487558978/internal/go-sso/oidcauth/oidcauthtest/testing.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int options = Start_options;
	Wgdef s_httpServer_wg;
	int i;
		for(i : 1.. options) {
for10:
	};
	run wgMonitor(s_httpServer_wg);
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
