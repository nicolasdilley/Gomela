#define prefixes  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example391587469/functional/runner/watch_command.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int wcs = 5;
	int prefixes = 5;
	int i;
	int keys = 5;
	int watchPerPrefix = 5;
	int rcs = 5;
	bool state = false;
	run wgMonitor(wg);
	run Anonymous0(wg);
		for(i : 1.. prefixes) {
for20:				for(i : 0.. watchPerPrefix-1) {
for21:			wg.Add!1;
			run Anonymous1(wg)
		};
for21_exit:
	};
	wg.Wait?0;
	do
	:: true -> 
for30:
	:: true -> 
		break
	od;
	do
	:: true -> 
for40:
	:: true -> 
		break
	od
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
for11:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
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
