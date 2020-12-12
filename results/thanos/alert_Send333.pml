#define Send_s_alertmanagers  ??
#define Send_am_dispatcher_Endpoints37621  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example601626616/pkg/alert/alert.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int am_dispatcher_Endpoints37621 = Send_am_dispatcher_Endpoints37621;
	Wgdef wg;
	bool state = false;
	int s_alertmanagers = Send_s_alertmanagers;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. s_alertmanagers-1) {
for20:				for(i : 0.. am_dispatcher_Endpoints37621-1) {
for21:			wg.Add!1;
			run Anonymous0(wg)
		}
	};
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
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
	od
}
