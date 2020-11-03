#define NewMux_opts 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example951432473/apiserver/apiserverhttp/mux.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef m_clients;
	int i;
	int opts = NewMux_opts;
	bool state = false;
	run wgMonitor(m_clients);
		for(i : 0.. opts-1) {
for10:
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
	od
}

