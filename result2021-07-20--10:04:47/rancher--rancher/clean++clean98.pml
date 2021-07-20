// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rancher/rancher/blob/91a6f51f259acd5670ff167d6bcf1916da7406f1/pkg/agent/clean/binding.go#L98
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_clean980 = [1] of {int};
	run clean98(child_clean980);
	run receiver(child_clean980)
stop_process:skip
}

proctype clean98(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Anonymousclean1361261 = [1] of {int};
	chan child_Anonymousclean1291260 = [1] of {int};
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
	run Anonymousclean129126(waitGroup,child_Anonymousclean1291260);
	run receiver(child_Anonymousclean1291260);
	run Anonymousclean136126(waitGroup,child_Anonymousclean1361261);
	run receiver(child_Anonymousclean1361261);
	waitGroup.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Anonymousclean129126(Wgdef waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	waitGroup.update!-1;
	stop_process: skip;
	child!0
}
proctype Anonymousclean136126(Wgdef waitGroup;chan child) {
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

proctype receiver(chan c) {
c?0
}

