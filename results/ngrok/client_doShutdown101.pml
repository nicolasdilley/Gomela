#define doShutdown_ctl_views  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example273708690/src/ngrok/client/controller.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int ctl_views = doShutdown_ctl_views;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!ctl_views + 1;
	wg.Wait?0
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
