
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example172228913/gorush/worker.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int req_Notifications = 5;
	Wgdef wg;
	int newNotification = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. req_Notifications) {
for10:		

		if
		:: true;
		:: true;
		:: true;
		fi
	};
		for(i : 1.. newNotification) {
for20:
	};
	
	if
	:: true -> 
		wg.Wait?0
	:: true;
	fi;
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