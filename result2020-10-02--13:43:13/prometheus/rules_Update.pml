
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example279528907/rules/manager.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int errs = 5;
	bool state = false;
	int m_groups = 5;
	Wgdef wg;
	int groups = 5;
	int i;
	
	if
	:: true -> 
				for(i : 1.. errs) {
for10:
		};
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 1.. groups) {
for20:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Add!m_groups;
		for(i : 1.. m_groups) {
for30:		run Anonymous1(wg)
	};
	wg.Wait?0;
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
