
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example529324227/provider/azure/environ.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int deleteResults = 5;
	Wgdef wg;
	bool state = false;
	int cancelResults = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 1.. ids) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
		for(i : 1.. cancelResults) {
for20:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	};
	
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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. ids) {
for30:		wg.Add!1;
		run Anonymous1(wg)
	};
	wg.Wait?0;
		for(i : 1.. deleteResults) {
for40:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
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
