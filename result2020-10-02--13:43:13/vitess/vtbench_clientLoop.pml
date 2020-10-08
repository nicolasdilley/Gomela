
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example862180471/go/vtbench/vtbench.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef b_wg;
	int i;
	int b_Count = 5;
	bool state = false;
	run wgMonitor(b_wg);
	b_wg.Add!-1;
	
	if
	:: 0 != -1 && b_Count-1 != -1 -> 
				for(i : 0.. b_Count-1) {
for10:			
			if
			:: true -> 
				break
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	b_wg.Add!-1
stop_process:}

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
