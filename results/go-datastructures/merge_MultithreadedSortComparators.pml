#define lb_for45_0  -1
#define ub_for45_1  -1
#define lb_for48_2  -1
#define ub_for48_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example872922038/sort/sort.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int chunks = 5;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!chunks;
		for(i : 0.. chunks-1) {
for10:		run Anonymous0(wg)
	};
for10_exit:	wg.Wait?0;
	do
	:: true -> 
for20:		wg.Add!chunks / 2;
				for(i : lb_for48_2.. ub_for48_3) {
for21:			run Anonymous1(wg)
		};
for21_exit:		wg.Wait?0;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for20_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
}
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
