
// /tmp/clone-example746219978/src/source_controller/coreservice/core/operation/inner_chart.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!3;
	run Anonymous0(wg);
	run Anonymous2(wg);
	run Anonymous4(wg);
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype mModelInstCount(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int modelInfos=1;
	
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
				for(i : 0.. modelInfos-1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_mModelInstCount0 = [0] of {int};
	run mModelInstCount(wg,child_mModelInstCount0);
	child_mModelInstCount0?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:
}
proctype mModelInstChange(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	goto stop_process;
stop_process:	child!0
}
proctype Anonymous2(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_mModelInstChange1 = [0] of {int};
	run mModelInstChange(wg,child_mModelInstChange1);
	child_mModelInstChange1?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:
}
proctype mBizHostCountChange(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype Anonymous4(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_mBizHostCountChange2 = [0] of {int};
	run mBizHostCountChange(wg,child_mBizHostCountChange2);
	child_mBizHostCountChange2?0;
	
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

