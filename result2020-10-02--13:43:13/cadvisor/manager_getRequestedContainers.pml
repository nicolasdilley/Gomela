
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example924497976/manager/manager.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int containersMap = 5;
	bool state = false;
	int i;
	

	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	:: true -> 
		goto stop_process
	fi;
	
	if
	:: true -> 
		Wgdef waitGroup;
		run wgMonitor(waitGroup);
		waitGroup.Add!containersMap;
				for(i : 1.. containersMap) {
for10:			run Anonymous0(waitGroup)
		};
		waitGroup.Wait?0
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef waitGroup) {
	bool closed; 
	int i;
	waitGroup.Add!-1;
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
