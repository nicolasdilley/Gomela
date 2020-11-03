
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example589327031/src/source_controller/coreservice/core/operation/inner_chart.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!2;
	run Anonymous0(wg);
	run Anonymous2(wg);
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype mModelInst(Wgdef wg;chan child) {
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
		fi
	:: true;
	fi;
	do
	:: true -> 
for10:		do
		:: true -> 
for11:
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	wg.Add!-1;
	child!0
}
proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_mModelInst0 = [0] of {int};
	run mModelInst(wg,child_mModelInst0);
	child_mModelInst0?0;
	
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
stop_process:	wg.Add!-1;
	child!0
}
proctype Anonymous2(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_mBizHostCountChange1 = [0] of {int};
	run mBizHostCountChange(wg,child_mBizHostCountChange1);
	child_mBizHostCountChange1?0;
	
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
