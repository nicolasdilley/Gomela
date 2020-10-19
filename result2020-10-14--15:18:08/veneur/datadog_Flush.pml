#define Flush_workers  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example111589635/sinks/datadog/datadog.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int workers = Flush_workers;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. workers-1) {
for10:		wg.Add!1;
		run go_ddflushPart(wg)
	};
for10_exit:	wg.Wait?0;
	goto stop_process
stop_process:}

proctype go_ddflushPart(Wgdef wg) {
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
