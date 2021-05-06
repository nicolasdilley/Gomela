
// https://github.com/rancher/rancher/blob/master/pkg/agent/clean/binding.go#L90
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_clean900 = [1] of {int};
	run clean90(child_clean900)
stop_process:skip
}

proctype clean90(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Anonymousclean1281181 = [1] of {int};
	chan child_Anonymousclean1211180 = [1] of {int};
	Wgdef waitGroup;
	

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
		fi
	fi;
	run wgMonitor(waitGroup);
	waitGroup.update!2;
	run Anonymousclean121118(waitGroup,child_Anonymousclean1211180);
	run Anonymousclean128118(waitGroup,child_Anonymousclean1281181);
	waitGroup.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Anonymousclean121118(Wgdef waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	waitGroup.update!-1;
	stop_process: skip;
	child!0
}
proctype Anonymousclean128118(Wgdef waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	waitGroup.update!-1;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

