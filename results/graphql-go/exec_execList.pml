
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example562665778/internal/exec/exec.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int entryouts = 5;
	int l = 5;
	int i;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
		wg.Add!l;
				for(i : 0.. l-1) {
for10:			run Anonymous0(wg)
		};
for10_exit:		wg.Wait?0
	:: true -> 
		
		if
		:: 0 != -1 && l-1 != -1 -> 
						for(i : 0.. l-1) {
for20:
			}
		:: else -> 
			do
			:: true -> 
for20:
			:: true -> 
				break
			od
		fi;
for20_exit:
	:: true -> 
		
		if
		:: 0 != -1 && l-1 != -1 -> 
						for(i : 0.. l-1) {
for20:
			}
		:: else -> 
			do
			:: true -> 
for20:
			:: true -> 
				break
			od
		fi;
for20_exit:
	fi;
	do
	:: true -> 
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		break
	od
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
