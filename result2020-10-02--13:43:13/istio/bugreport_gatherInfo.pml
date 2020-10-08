
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example029423492/tools/bug-report/pkg/bugreport/bugreport.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_bugreportgetFromCluster5 = [0] of {int};
	chan child_bugreportgetFromCluster1 = [0] of {int};
	Wgdef mandatoryWg;
	chan child_bugreportgetFromCluster3 = [0] of {int};
	int i;
	chan child_bugreportgetFromCluster0 = [0] of {int};
	chan child_bugreportgetFromCluster2 = [0] of {int};
	chan child_bugreportgetFromCluster4 = [0] of {int};
	Wgdef optionalWg;
	bool state = false;
	run wgMonitor(mandatoryWg);
	run bugreportgetFromCluster(mandatoryWg,child_bugreportgetFromCluster0);
	child_bugreportgetFromCluster0?0;
	run bugreportgetFromCluster(child_bugreportgetFromCluster1);
	child_bugreportgetFromCluster1?0;
	run bugreportgetFromCluster(child_bugreportgetFromCluster2);
	child_bugreportgetFromCluster2?0;
	run bugreportgetFromCluster(child_bugreportgetFromCluster3);
	child_bugreportgetFromCluster3?0;
	run bugreportgetFromCluster(child_bugreportgetFromCluster4);
	child_bugreportgetFromCluster4?0;
	run bugreportgetFromCluster(child_bugreportgetFromCluster5);
	child_bugreportgetFromCluster5?0;
	run wgMonitor(optionalWg);
		for(i : 1.. paths) {
for10:		

		if
		:: true -> 
			chan child_bugreportgetFromCluster6 = [0] of {int};
			run bugreportgetFromCluster(child_bugreportgetFromCluster6);
			child_bugreportgetFromCluster6?0;
			chan child_bugreportgetFromCluster7 = [0] of {int};
			run bugreportgetFromCluster(child_bugreportgetFromCluster7);
			child_bugreportgetFromCluster7?0;
			chan child_bugreportgetFromCluster8 = [0] of {int};
			run bugreportgetFromCluster(child_bugreportgetFromCluster8);
			child_bugreportgetFromCluster8?0
		:: true -> 
			chan child_bugreportgetFromCluster9 = [0] of {int};
			run bugreportgetFromCluster(child_bugreportgetFromCluster9);
			child_bugreportgetFromCluster9?0
		fi
	};
	mandatoryWg.Wait?0;
	run Anonymous2(mandatoryWg,optionalWg)
stop_process:}

proctype bugreportgetFromCluster(Wgdef wg;chan child) {
	bool closed; 
	int i;
	wg.Add!1;
	run Anonymous1();
	child!0;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous2(Wgdef mandatoryWg;Wgdef optionalWg) {
	bool closed; 
	int i;
	optionalWg.Wait?0;
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
