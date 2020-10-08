
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example947739188/session.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int newHosts = 5;
	bool state = false;
	int hostMap = 5;
	Wgdef wg;
	int hosts = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
						for(i : 1.. newHosts) {
for10:
			}
		:: true;
		fi
	:: true;
	fi;
		for(i : 1.. hosts) {
for20:
	};
	run wgMonitor(wg);
		for(i : 1.. hostMap) {
for30:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
	
	if
	:: true -> 
				for(i : 1.. hosts) {
for40:
		}
	:: true -> 
				for(i : 1.. hosts) {
for40:
		}
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
	wg.Add!-1;
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
