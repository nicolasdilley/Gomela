
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example814430198/github.com/miekg/dns/singleinflight.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef _wg;
	Wgdef c_wg;
	bool state = false;
	int i;
	run wgMonitor(c_wg);
	

	if
	:: true -> 
		c_wg.Wait?0;
		goto stop_process
	:: true;
	fi;
	c_wg.Add!1;
	run wgMonitor(_wg);
	c_wg.Add!-1;
	goto stop_process
stop_process:skip
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

