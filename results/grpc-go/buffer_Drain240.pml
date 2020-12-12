#define Drain_int2499  ??
#define Drain_qs  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example694317116/internal/profiling/buffer/buffer.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int qs = Drain_qs;
	Wgdef wg;
	bool state = false;
	int int2499 = Drain_int2499;
	int i;
for10_exit:	run wgMonitor(wg);
	wg.Add!int2499;
for20_exit:	wg.Wait?0;
for30_exit:for40_exit:	goto stop_process
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
