#define cleanAttributeFieldInInstances_objectFields  3
#define cleanAttributeFieldInInstances_objFields  0
#define lb_for429_2  -1
#define ub_for429_3  -1

// /tmp/clone-example746219978/src/source_controller/coreservice/core/model/attribute_curd.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int objectFields = cleanAttributeFieldInInstances_objectFields;
	Wgdef wg;
	int objFields = cleanAttributeFieldInInstances_objFields;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. objectFields-1) {
for20:				for(i : 0.. objFields-1) {
for21:			
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
						fi
					:: true;
					fi
				fi
			fi;
			wg.Add!1;
			run Anonymous0(wg)
		}
	};
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
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for429_2 != -2 && ub_for429_3 != -2 -> 
				for(i : lb_for429_2.. ub_for429_3) {
for23:			
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
						for(i : 0.. insts-1) {
for24:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			};
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for23:			
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
						for(i : 0.. insts-1) {
for24:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			};
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for23_exit:stop_process:	wg.Add!-1
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
