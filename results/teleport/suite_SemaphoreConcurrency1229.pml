#define SemaphoreConcurrency_int64124911  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example809394708/lib/services/suite/suite.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int int64124911 = SemaphoreConcurrency_int64124911;
	bool state = false;
	run wgMonitor(wg);
		for(i : int64124911.. 200-1) {
for10:		wg.Add!1;
		run Anonymous0(wg)
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
	od
}
