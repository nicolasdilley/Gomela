
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example593706384/upgrade.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int develUp = -2;
	Wgdef wg;
	int i;
	int _aurdata = -2;
	int aurUp = -2;
	bool state = false;
	run wgMonitor(wg);
	
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
						for(i : 0.. _aurdata-1) {
for20:
			};
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
				for(i : 0.. develUp-1) {
for30:
		};
				for(i : 0.. aurUp-1) {
for40:
		}
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
stop_process:
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
