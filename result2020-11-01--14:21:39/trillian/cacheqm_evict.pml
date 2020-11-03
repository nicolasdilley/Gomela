#define evict_m_cache 1
#define evict_evicts 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example444790199/quota/cacheqm/cache.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int evicts = evict_evicts;
	Wgdef wg;
	bool state = false;
	int m_cache = evict_m_cache;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. m_cache-1) {
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
	bool state;
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

