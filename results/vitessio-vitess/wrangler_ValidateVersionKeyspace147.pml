#define ValidateVersionKeyspace_shards  3
#define ValidateVersionKeyspace_aliases  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example245190199/go/vt/wrangler/version.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int aliases = ValidateVersionKeyspace_aliases;
	int shards = ValidateVersionKeyspace_shards;
	

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
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. shards-1) {
		for10: skip;
		

		if
		:: true -> 
			goto for10_end
		:: true;
		fi;
				for(i : 0.. aliases-1) {
			for11: skip;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			wg.Add!1;
			run go_diffVersion(wg);
			for11_end: skip
		};
		for11_exit: skip;
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_diffVersion(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
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

