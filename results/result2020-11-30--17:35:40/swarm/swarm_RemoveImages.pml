#define RemoveImages_c_listActiveEngines55420  1
#define RemoveImages_e_Images55525  1

// /tmp/clone-example417708962/cluster/swarm/cluster.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int c_listActiveEngines55420 = RemoveImages_c_listActiveEngines55420;
	Wgdef wg;
	int e_Images55525 = RemoveImages_e_Images55525;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. c_listActiveEngines55420-1) {
for10:				for(i : 0.. e_Images55525-1) {
for11:			
			if
			:: true -> 
				wg.Add!1;
				run Anonymous0(wg)
			:: true;
			fi
		}
	};
	wg.Wait?0;
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
