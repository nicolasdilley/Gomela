#define userPreload_uidSet  3

// https://github.com/keybase/client/blob/cd76ccb97183c2be78b869fab9aed4b6f5b11086/go/teams/loader.go#L1254
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int uidSet = userPreload_uidSet;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run wgMonitor(wg);
						for(i : 0.. uidSet-1) {
				for20: skip;
				wg.Add!1;
				run go_Anonymous0(wg);
				for20_end: skip
			};
			for20_exit: skip;
			

			if
			:: true -> 
				wg.Wait?0
			:: true;
			fi
		fi
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Add!-1;
	stop_process: skip
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

