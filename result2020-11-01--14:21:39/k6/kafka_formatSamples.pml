#define formatSamples_samples 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example527800442/stats/kafka/collector.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int samples = formatSamples_samples;
	bool state = false;
	int i;
	

	if
	:: true -> 
		Wgdef i_wg;
		run wgMonitor(i_wg);
		
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
				for(i : 0.. samples-1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	fi;
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

