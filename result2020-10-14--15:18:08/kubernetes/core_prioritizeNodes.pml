#define prioritizeNodes_nodes  60
#define prioritizeNodes_scoresMap  60
#define prioritizeNodes_g_extenders  60
#define prioritizeNodes_prioritizedList  60
#define prioritizeNodes_result  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example603064843/pkg/scheduler/core/generic_scheduler.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int nodes = prioritizeNodes_nodes;
	int result = prioritizeNodes_result;
	int g_extenders = prioritizeNodes_g_extenders;
	bool state = false;
	int scoresMap = prioritizeNodes_scoresMap;
	int prioritizedList = prioritizeNodes_prioritizedList;
	int i;
	
	if
	:: true -> 
				for(i : 1.. nodes) {
for10:
		};
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
				for(i : 1.. scoresMap) {
for20:
		}
	:: true;
	fi;
		for(i : 1.. nodes) {
for30:				for(i : 1.. scoresMap) {
for31:
		}
	};
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 1.. g_extenders) {
for40:			wg.Add!1;
			run Anonymous0(wg)
		};
		wg.Wait?0;
				for(i : 1.. result) {
for50:
		}
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 1.. result) {
for60:
		}
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. prioritizedList) {
for41:
	};
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
	od;
stop_process:
}
