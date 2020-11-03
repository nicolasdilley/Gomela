#define GetLookupdTopicProducers_lookupdHTTPAddrs 0
#define GetLookupdTopicProducers_resp_Producers 1
#define GetLookupdTopicProducers_producers 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example519737571/internal/clusterinfo/data.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int resp_Producers = GetLookupdTopicProducers_resp_Producers;
	Wgdef wg;
	int i;
	int lookupdHTTPAddrs = GetLookupdTopicProducers_lookupdHTTPAddrs;
	int producers = GetLookupdTopicProducers_producers;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. lookupdHTTPAddrs-1) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
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
		for(i : 0.. resp_Producers-1) {
for11:				for(i : 0.. producers-1) {
for12:			
			if
			:: true -> 
				goto skip
			:: true;
			fi
		};
skip:		
	};
stop_process:	wg.Add!-1
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

