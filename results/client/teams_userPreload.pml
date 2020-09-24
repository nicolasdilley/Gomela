#define uidSet  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example131909709/go/teams/loader.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int uidSet = 5;
	bool state = false;
	int i;
	
	if
	:: true -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			Wgdef wg;
			run wgMonitor(wg);
						for(i : 1.. uidSet) {
for20:				wg.Add!1;
				run Anonymous0(wg)
			};
			
			if
			:: true -> 
				wg.Wait?0
			:: true;
			fi
		:: true -> 
			do
			:: true -> 
for30:
			:: true -> 
				break
			od
		:: true -> 
			do
			:: true -> 
for30:
			:: true -> 
				break
			od
		fi
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
