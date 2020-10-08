
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example531761686/pkg/executor/executortype/poolmgr/gpm.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int podList_Items = 5;
	Wgdef wg;
	bool state = false;
	int envs_Items = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 1.. envs_Items) {
for10:		
		if
		:: true -> 
			wg.Add!1;
			run Anonymous0()
		:: true;
		fi
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. podList_Items) {
for20:		wg.Add!1;
		run Anonymous1()
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1() {
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
