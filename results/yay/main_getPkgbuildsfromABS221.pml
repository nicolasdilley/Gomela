#define getPkgbuildsfromABS_names  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example593706384/download.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int names = getPkgbuildsfromABS_names;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. names-1) {
for20:		wg.Add!1;
		
		if
		:: true -> 
			wg.Wait?0
		:: true;
		fi
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

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
