#define lb_for65_0  -1
#define ub_for65_1  -1
#define lb_for95_2  -1
#define ub_for95_3  -1
#define lb_for129_4  -1
#define ub_for129_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example354285826/test/e2e/instrumentation/logging/elasticsearch/utils.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef f_logsSizeWaitGroup;
	bool state = false;
	run wgMonitor(f_logsSizeWaitGroup);
	
	if
	:: lb_for65_0 != -2 && ub_for65_1 != -2 -> 
				for(i : lb_for65_0.. ub_for65_1) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
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
	
	if
	:: lb_for95_2 != -2 && ub_for95_3 != -2 -> 
				for(i : lb_for95_2.. ub_for95_3) {
for30:			break
		}
	:: else -> 
		do
		:: true -> 
for30:			break
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for129_4 != -2 && ub_for129_5 != -2 -> 
				for(i : lb_for129_4.. ub_for129_5) {
for40:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for40:			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for40_exit:	
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
