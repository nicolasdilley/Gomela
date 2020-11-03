#define queueNotification_req_Notifications 0
#define queueNotification_newNotification 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example592542884/gorush/worker.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int req_Notifications = queueNotification_req_Notifications;
	Wgdef wg;
	int newNotification = queueNotification_newNotification;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. req_Notifications-1) {
for10:		

		if
		:: true;
		:: true;
		:: true;
		fi
	};
		for(i : 0.. newNotification-1) {
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

