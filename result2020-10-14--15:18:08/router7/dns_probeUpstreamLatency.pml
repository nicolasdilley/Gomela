#define probeUpstreamLatency_upstreams  60
#define probeUpstreamLatency_results  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example610302544/internal/dns/dns.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int upstreams = probeUpstreamLatency_upstreams;
	Wgdef wg;
	int results = probeUpstreamLatency_results;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. upstreams) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
		for(i : 1.. results) {
for20:
	}
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
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
