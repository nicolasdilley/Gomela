#define startTask_n_ops 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example411586957/posting/mvcc.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef _waiting;
	Wgdef closer_waiting;
	int n_ops = startTask_n_ops;
	bool state = false;
	run wgMonitor(closer_waiting);
	

	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	:: true -> 
		do
		:: true -> 
for20:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	:: true -> 
		do
		:: true -> 
for30:			
			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
		:: true -> 
			break
		od
	:: true -> 
		goto stop_process
	fi;
	run wgMonitor(_waiting);
	run Anonymous0();
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
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
	od
}

