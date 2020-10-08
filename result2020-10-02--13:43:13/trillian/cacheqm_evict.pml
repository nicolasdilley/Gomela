
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example661427707/quota/cacheqm/cache.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int evicts = 5;
	Wgdef wg;
	bool state = false;
	int m_cache = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. m_cache) {
for10:
	};
	run wgMonitor(wg);
		for(i : 0.. evicts-1) {
for20:		wg.Add!1;
		run Anonymous0()
	};
for20_exit:	wg.Wait?0
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
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
