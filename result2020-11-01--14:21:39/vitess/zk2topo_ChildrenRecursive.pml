#define ChildrenRecursive_children 0
#define ChildrenRecursive_rChildren 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example345111863/go/vt/topo/zk2topo/utils.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int children = ChildrenRecursive_children;
	Wgdef wg;
	int rChildren = ChildrenRecursive_rChildren;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. children-1) {
for10:		wg.Add!1;
		run Anonymous0()
	};
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
				for(i : 0.. rChildren-1) {
for11:
		}
	:: true -> 
				for(i : 0.. rChildren-1) {
for11:
		}
	fi;
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

