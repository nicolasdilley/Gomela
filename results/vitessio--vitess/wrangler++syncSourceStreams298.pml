#define syncSourceStreams_sm_streams  0
#define syncSourceStreams_tabletStreams  1

// https://github.com/vitessio/vitess/blob/d09dffef0c60d5d4841cac86bdf4ed777098b60a/go/vt/wrangler/stream_migrater.go#L298
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int tabletStreams = syncSourceStreams_tabletStreams;
	int sm_streams = syncSourceStreams_sm_streams;
	run wgMonitor(wg);
		for(i : 0.. sm_streams-1) {
		for20: skip;
				for(i : 0.. tabletStreams-1) {
			for21: skip;
			

			if
			:: true -> 
				goto for21_end
			:: true;
			fi;
			wg.Add!1;
			run go_Anonymous0(wg);
			for21_end: skip
		};
		for21_exit: skip;
		for20_end: skip
	};
	for20_exit: skip;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

