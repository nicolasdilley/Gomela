#define p_publishers  5
#define p_subscribers  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example083362333/x/vm/pubsub.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int p_publishers = 5;
	int i;
	int p_subscribers = 5;
	Wgdef wg;
	int p_publishers[i]_subscribers = 5;
	int p_subscribers[i]_publishers = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. p_publishers) {
for10:		wg.Add!1
	};
		for(i : 1.. p_subscribers) {
for20:		wg.Add!1
	};
	goto stop_process
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
