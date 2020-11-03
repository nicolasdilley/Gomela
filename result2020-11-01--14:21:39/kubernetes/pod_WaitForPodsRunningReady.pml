#define WaitForPodsRunningReady_rcList_Items 1
#define WaitForPodsRunningReady_rsList_Items 0
#define WaitForPodsRunningReady_podList_Items 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example808497976/test/e2e/framework/pod/wait.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int rsList_Items = WaitForPodsRunningReady_rsList_Items;
	Wgdef wg;
	int i;
	int rcList_Items = WaitForPodsRunningReady_rcList_Items;
	int podList_Items = WaitForPodsRunningReady_podList_Items;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!1;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

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

