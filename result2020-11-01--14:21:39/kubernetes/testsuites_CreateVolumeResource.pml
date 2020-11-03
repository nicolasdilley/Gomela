
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example808497976/test/e2e/storage/testsuites/base.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef f_logsSizeWaitGroup;
	bool state = false;
	run wgMonitor(f_logsSizeWaitGroup);
	

	if
	:: true;
	:: true;
	:: true -> 
		
		if
		:: true -> 
			

			if
			:: true;
			:: true;
			fi
		:: true;
		fi
	:: true;
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
