
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example700683195/fs/sync/sync.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef do_deletersWg;
	Wgdef do_trackRenamesWg;
	Wgdef do_transfersWg;
	bool state = false;
	Wgdef do_checkerWg;
	Wgdef do_renamerWg;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		Wgdef do_deletersWg;
		run wgMonitor(do_deletersWg);
		Wgdef do_checkerWg;
		run wgMonitor(do_checkerWg);
		Wgdef do_transfersWg;
		run wgMonitor(do_transfersWg);
		Wgdef do_renamerWg;
		run wgMonitor(do_renamerWg);
		Wgdef do_trackRenamesWg;
		run wgMonitor(do_trackRenamesWg);
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run wgMonitor(do_deletersWg);
	run wgMonitor(do_checkerWg);
	run wgMonitor(do_transfersWg);
	run wgMonitor(do_renamerWg);
	run wgMonitor(do_trackRenamesWg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

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
