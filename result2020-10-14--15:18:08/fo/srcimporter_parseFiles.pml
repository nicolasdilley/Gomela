#define parseFiles_filenames  60
#define parseFiles_errors  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example929115455/internal/srcimporter/srcimporter.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int filenames = parseFiles_filenames;
	Wgdef wg;
	int errors = parseFiles_errors;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!filenames;
		for(i : 1.. filenames) {
for10:		run Anonymous0(wg)
	};
	wg.Wait?0;
		for(i : 1.. errors) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
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
