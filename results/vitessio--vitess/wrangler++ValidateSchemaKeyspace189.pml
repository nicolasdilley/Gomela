#define ValidateSchemaKeyspace_aliases  1
#define not_found_shards21324  1

// https://github.com/vitessio/vitess/blob/d09dffef0c60d5d4841cac86bdf4ed777098b60a/go/vt/wrangler/schema.go#L189
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int aliases = ValidateSchemaKeyspace_aliases;
	

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
		for(i : 0.. not_found_shards21324-1) {
		for10: skip;
		

		if
		:: true -> 
			goto for10_end
		:: true;
		fi;
		

		if
		:: true -> 
			goto for10_end
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
			run go_diffSchema(wg);
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

proctype go_diffSchema(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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

