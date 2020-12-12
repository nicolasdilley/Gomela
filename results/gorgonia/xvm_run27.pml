#define run_p_publishers  ??
#define run_p_subscribers  ??
#define run_p_subscribers[i]_publishers  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example732766036/x/vm/pubsub.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int p_subscribers = run_p_subscribers;
	Wgdef wg;
	int i;
	int p_publishers = run_p_publishers;
	int p_subscribers[i]_publishers = run_p_subscribers[i]_publishers;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. p_publishers-1) {
for10:		wg.Add!1
	};
		for(i : 0.. p_subscribers-1) {
for20:		wg.Add!1
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
