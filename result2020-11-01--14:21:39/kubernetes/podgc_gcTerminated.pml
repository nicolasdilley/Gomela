#define gcTerminated_pods 0
#define gcTerminated_deleteCount 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example808497976/pkg/controller/podgc/gc_controller.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int deleteCount = gcTerminated_deleteCount;
	Wgdef wait;
	bool state = false;
	int pods = gcTerminated_pods;
	int i;
		for(i : 0.. pods-1) {
for10:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wait);
		for(i : 0.. deleteCount-1) {
for20:		wait.Add!1;
		run Anonymous0(wait)
	};
for20_exit:	wait.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wait) {
	bool closed; 
	int i;
	bool state;
stop_process:	wait.Add!-1
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

