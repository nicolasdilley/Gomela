#define run_p_publishers  3
#define run_p_subscribers  1
#define run_p_subscribersLiL_publishers  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example976383338/x/vm/pubsub.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int p_subscribersLiL_publishers = run_p_subscribersLiL_publishers;
	int p_subscribers = run_p_subscribers;
	int p_publishers = run_p_publishers;
	run wgMonitor(wg);
		for(i : 0.. p_publishers-1) {
		for10: skip;
		wg.Add!1;
		for10_end: skip
	};
	for10_exit: skip;
		for(i : 0.. p_subscribers-1) {
		for20: skip;
		wg.Add!1;
		for20_end: skip
	};
	for20_exit: skip;
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

