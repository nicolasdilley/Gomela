#define prioritizeNodes_g_extenders  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example354285826/pkg/scheduler/core/generic_scheduler.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int scoresMap = -2;
	bool state = false;
	int result = -2;
	int nodes = -2;
	int g_extenders = prioritizeNodes_g_extenders;
	int i;
	
	if
	:: true -> 
				for(i : 0.. nodes-1) {
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
				for(i : 0.. scoresMap-1) {
for20:
		}
	:: true;
	fi;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 0.. g_extenders-1) {
for40:			wg.Add!1;
			run Anonymous0(wg)
		};
		wg.Wait?0;
				for(i : 0.. result-1) {
for50:
		}
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. result-1) {
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
	do
	:: true -> 
for41:
	:: true -> 
		break
	od;
stop_process:	wg.Add!-1
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
