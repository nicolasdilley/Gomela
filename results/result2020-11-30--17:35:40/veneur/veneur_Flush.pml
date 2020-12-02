#define Flush_s_metricSinks  3

// /tmp/clone-example519058511/flusher.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int s_metricSinks = Flush_s_metricSinks;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: true -> 
		wg.Add!1;
		
		if
		:: true -> 
			run Anonymous0(wg)
		:: true -> 
			run Anonymous1(wg)
		:: true -> 
			run Anonymous1(wg)
		fi
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. s_metricSinks-1) {
for20:		wg.Add!1;
		run Anonymous2(wg)
	};
	wg.Wait?0;
	run Anonymous3(wg)
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
stop_process:
}
proctype Anonymous3(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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
	od
}
