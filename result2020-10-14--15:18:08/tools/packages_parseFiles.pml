#define parseFiles_filenames  60
#define parseFiles_parsed  60
#define parseFiles_errors  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example971953206/go/packages/packages.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int parsed = parseFiles_parsed;
	Wgdef wg;
	int i;
	int filenames = parseFiles_filenames;
	int errors = parseFiles_errors;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. filenames) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
		for(i : 1.. parsed) {
for20:
	};
		for(i : 1.. errors) {
for30:
	};
	goto stop_process
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
	od;
stop_process:
}
