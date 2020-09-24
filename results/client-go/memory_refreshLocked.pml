#define g_Versions  5
#define gl_Groups  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example379071371/discovery/cached/memory/memcache.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int g_Versions = 5;
	Wgdef wg;
	bool state = false;
	int gl_Groups = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 1.. gl_Groups) {
for10:				for(i : 1.. g_Versions) {
for11:			wg.Add!1;
			run Anonymous0()
		}
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
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
