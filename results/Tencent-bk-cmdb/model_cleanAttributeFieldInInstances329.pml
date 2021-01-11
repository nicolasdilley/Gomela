#define cleanAttributeFieldInInstances_objectFields  3
#define cleanAttributeFieldInInstances_objFields  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example358165944/src/source_controller/coreservice/core/model/attribute_curd.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int objFields = cleanAttributeFieldInInstances_objFields;
	int objectFields = cleanAttributeFieldInInstances_objectFields;
	run wgMonitor(wg);
		for(i : 0.. objectFields-1) {
		for20: skip;
		

		if
		:: true -> 
			goto for20_end
		:: true;
		fi;
				for(i : 0.. objFields-1) {
			for21: skip;
			

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
					fi;
					goto for22_end
				:: true;
				fi
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
						goto for22_end
					:: true;
					fi
				fi
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
						goto for22_end
					:: true;
					fi
				fi
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Wait?0;
	

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
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
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

