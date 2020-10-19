#define Subscribe_s_subscriberClients  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example692657136/weed/messaging/msgclient/subscriber.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int s_subscriberClients = Subscribe_s_subscriberClients;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. s_subscriberClients-1) {
for10:		
		if
		:: true -> 
			wg.Add!1;
			run Anonymous0(wg)
		:: true;
		fi
	};
for10_exit:	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
stop_process:
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
