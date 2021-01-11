#define Send_s_alertmanagers  3
#define Send_am_dispatcher_Endpoints37621  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example023686894/pkg/alert/alert.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int am_dispatcher_Endpoints37621 = Send_am_dispatcher_Endpoints37621;
	int s_alertmanagers = Send_s_alertmanagers;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. s_alertmanagers-1) {
		for20: skip;
				for(i : 0.. am_dispatcher_Endpoints37621-1) {
			for21: skip;
			wg.Add!1;
			run go_Anonymous0(wg);
			for21_end: skip
		};
		for21_exit: skip;
		for20_end: skip
	};
	for20_exit: skip;
	wg.Wait?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
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

