#define runTest_numGoroutines  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example946677975/badger/cmd/bank.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int numGoroutines = runTest_numGoroutines;
	Wgdef wg;
	bool state = false;
	Wgdef subWg;
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
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
for10_exit:	run wgMonitor(wg);
	wg.Add!1;
	run Anonymous0(wg,subWg);
		for(i : 0.. numGoroutines-1) {
for30:		wg.Add!1;
		run Anonymous1(wg,subWg)
	};
for30_exit:	
	if
	:: true -> 
		wg.Add!1;
		run Anonymous2(wg,subWg)
	:: true;
	fi;
	wg.Add!1;
	run Anonymous3(wg,subWg);
	run wgMonitor(subWg);
	
	if
	:: true -> 
		subWg.Add!1;
		run Anonymous4(wg,subWg)
	:: true;
	fi;
	wg.Wait?0;
	
	if
	:: true -> 
		subWg.Wait?0
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg;Wgdef subWg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		
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
		break
	od;
stop_process:	wg.Add!-1
}
proctype Anonymous1(Wgdef wg;Wgdef subWg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for31:		
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
		break
	od;
stop_process:	wg.Add!-1
}
proctype Anonymous2(Wgdef wg;Wgdef subWg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for40:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		break
	od;
stop_process:	wg.Add!-1
}
proctype Anonymous3(Wgdef wg;Wgdef subWg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for50:		
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
		break
	od;
stop_process:	wg.Add!-1
}
proctype Anonymous4(Wgdef wg;Wgdef subWg) {
	bool closed; 
	int i;
	bool state;
for60_exit:stop_process:	subWg.Add!-1
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
