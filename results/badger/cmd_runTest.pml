
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example640268563/badger/cmd/bank.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int ticker_C = 5;
	Wgdef subWg;
	int list_Kv = 5;
	Wgdef wg;
	int numAccounts = 5;
	int numGoroutines = 5;
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
	
	if
	:: 0 != -1 && numAccounts-1 != -1 -> 
				for(i : 0.. numAccounts-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
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
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg;Wgdef subWg) {
	bool closed; 
	int i;
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
	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Wgdef wg;Wgdef subWg) {
	bool closed; 
	int i;
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
	wg.Add!-1;
stop_process:
}
proctype Anonymous3(Wgdef wg;Wgdef subWg) {
	bool closed; 
	int i;
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
	wg.Add!-1;
stop_process:
}
proctype Anonymous4(Wgdef wg;Wgdef subWg) {
	bool closed; 
	int i;
	
	if
	:: 0 != -1 && numAccounts-1 != -1 -> 
				for(i : 0.. numAccounts-1) {
for60:
		}
	:: else -> 
		do
		:: true -> 
for60:
		:: true -> 
			break
		od
	fi;
for60_exit:	subWg.Add!-1;
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
