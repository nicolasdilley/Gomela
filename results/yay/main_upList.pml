
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example467796103/upgrade.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int remote = 5;
	int i;
	int develUp = 5;
	Wgdef wg;
	int _aurdata = 5;
	int aurUp = 5;
	bool state = false;
	run wgMonitor(wg);
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		wg.Add!1;
		run Anonymous0(wg)
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			do
			:: true -> 
for20:
			:: true -> 
				break
			od;
			wg.Add!1;
			run Anonymous1(wg);
			
			if
			:: true -> 
				wg.Add!1;
				run Anonymous2(wg)
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	wg.Wait?0;
	
	if
	:: true -> 
		do
		:: true -> 
for30:
		:: true -> 
			break
		od;
		do
		:: true -> 
for40:
		:: true -> 
			break
		od
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
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Wgdef wg) {
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
