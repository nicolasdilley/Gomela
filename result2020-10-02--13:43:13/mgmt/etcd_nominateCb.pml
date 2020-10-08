
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example326115153/etcd/callback.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		wg.Add!1;
		run Anonymous0();
		do
		:: true;
		:: true -> 
			wg.Wait?0;
			goto stop_process
		od
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				
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
					fi
				:: true;
				fi
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
			fi
		:: true;
		fi
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	Chandef obj_errExitN;
	run sync_monitor(obj_errExitN);
	
	if
	:: true -> 
		do
		:: true;
		od
	:: true;
	fi;
	obj_errExitN.closing!true;
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
