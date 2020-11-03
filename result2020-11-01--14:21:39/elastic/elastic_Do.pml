#define Do_s_retryItemStatusCodes 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example005860366/bulk_processor.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int s_retryItemStatusCodes = Do_s_retryItemStatusCodes;
	Wgdef p_workerWg;
	int i;
		for(i : 0.. s_retryItemStatusCodes-1) {
for10:
	};
	run wgMonitor(p_workerWg);
	
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
	od
}

