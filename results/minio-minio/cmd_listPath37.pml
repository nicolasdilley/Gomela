#define listPath_z_serverPools  0
#define listPath_pool_sets  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example408925639/cmd/metacache-server-pool.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int pool_sets = listPath_pool_sets;
	int z_serverPools = listPath_z_serverPools;
	

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
		

		if
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. z_serverPools-1) {
		for10: skip;
				for(i : 0.. pool_sets-1) {
			for11: skip;
			wg.Add!1;
			run go_Anonymous0(wg);
			for11_end: skip
		};
		for11_exit: skip;
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	

	if
	:: true -> 
		run go_Anonymous1(wg);
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

