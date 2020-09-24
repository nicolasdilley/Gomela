
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example131909709/go/chat/uithreadloader.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int skips = 5;
	bool state = false;
	int changed = 5;
	Wgdef wg;
	int resolved = 5;
	int i;
	
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
	run wgMonitor(wg);
	wg.Add!1;
	run Anonymous0(wg);
	wg.Add!1;
	run Anonymous2(wg);
	wg.Wait?0;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: true -> 
for10:			
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
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
for11:
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
for12:
			:: true -> 
				break
			od
		:: true -> 
			break
		od;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		do
		:: true;
		:: true -> 
			goto stop_process
		od
	:: true;
	fi;
stop_process:
}
proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	Chandef ch;
	
	if
	:: 1 > 0 -> 
		ch.size = 1;
		run emptyChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run Anonymous0(wg);
	do
	:: true -> 
		goto stop_process
	od;
	do
	:: true -> 
		goto stop_process
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		
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
	fi;
	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Wgdef wg) {
	bool closed; 
	int i;
	
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
