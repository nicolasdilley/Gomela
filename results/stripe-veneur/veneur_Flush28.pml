#define Flush_s_metricSinks  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example980743093/flusher.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int s_metricSinks = Flush_s_metricSinks;
	run wgMonitor(wg);
	

	if
	:: true -> 
		wg.Add!1;
		

		if
		:: true -> 
			run go_Anonymous0(wg)
		:: true -> 
			run go_Anonymous1(wg)
		:: true -> 
			run go_Anonymous1(wg)
		fi
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. s_metricSinks-1) {
		for20: skip;
		wg.Add!1;
		run go_Anonymous2(wg);
		for20_end: skip
	};
	for20_exit: skip;
	wg.Wait?0;
	run go_Anonymous3(wg)
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
	stop_process: skip
}
proctype go_Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
	stop_process: skip
}
proctype go_Anonymous2(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
	stop_process: skip
}
proctype go_Anonymous3(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip
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

