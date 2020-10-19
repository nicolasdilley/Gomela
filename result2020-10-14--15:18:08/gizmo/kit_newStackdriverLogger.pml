#define newStackdriverLogger_lbls  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example761645178/server/kit/sd_log.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int lbls = newStackdriverLogger_lbls;
	Wgdef client_loggers;
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
								for(i : 1.. lbls) {
for10:
				}
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
		fi
	fi;
	run wgMonitor(client_loggers);
	
	if
	:: true -> 
		goto stop_process
	:: true;
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
	od;
stop_process:
}
