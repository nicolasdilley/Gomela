#define cleanAttributeFieldInInstances_attrs 1
#define cleanAttributeFieldInInstances_objBizFields 1
#define cleanAttributeFieldInInstances_objPublicFields 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example589327031/src/source_controller/coreservice/core/model/attribute_curd.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int attrs = cleanAttributeFieldInInstances_attrs;
	bool state = false;
	int objPublicFields = cleanAttributeFieldInInstances_objPublicFields;
	Wgdef wg;
	int objBizFields = cleanAttributeFieldInInstances_objBizFields;
	int i;
		for(i : 0.. attrs-1) {
for10:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
						for(i : 0.. objBizFields-1) {
for11:
			}
		fi
	};
	run wgMonitor(wg);
		for(i : 0.. objPublicFields-1) {
for20:		
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
		fi;
		wg.Add!1;
		run Anonymous0()
	};
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. objBizFields-1) {
for30:		
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
		wg.Add!1;
		run Anonymous1()
	};
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

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

