#define Init_pods_Items  60
#define lb_for65_1  -1
#define ub_for65_2  -1
#define lb_for95_3  -1
#define ub_for95_4  -1
#define lb_for129_5  -1
#define ub_for129_6  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example603064843/test/e2e/instrumentation/logging/elasticsearch/utils.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef f_logsSizeWaitGroup;
	int i;
	int pods_Items = Init_pods_Items;
	bool state = false;
	run wgMonitor(f_logsSizeWaitGroup);
	
	if
	:: lb_for65_1 != -1 && ub_for65_2 != -1 -> 
				for(i : lb_for65_1.. ub_for65_2) {
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
		for(i : 1.. pods_Items) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	
	if
	:: lb_for95_3 != -1 && ub_for95_4 != -1 -> 
				for(i : lb_for95_3.. ub_for95_4) {
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
	:: lb_for129_5 != -1 && ub_for129_6 != -1 -> 
				for(i : lb_for129_5.. ub_for129_6) {
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
	od;
stop_process:
}
