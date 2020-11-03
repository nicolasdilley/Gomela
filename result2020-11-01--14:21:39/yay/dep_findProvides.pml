#define findProvides_words 1
#define findProvides_results 0
#define findProvides_pkgs 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example834641366/pkg/dep/depPool.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int results = findProvides_results;
	Wgdef wg;
	int i;
	int words = findProvides_words;
	int pkgs = findProvides_pkgs;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. pkgs-1) {
for10:		wg.Add!1
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

