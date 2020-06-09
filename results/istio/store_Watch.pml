



init { 
	chan child_storenewQueue20 = [0] of {int};
	bool state = false;
	int i;
	
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
	run storenewQueue2(child_storenewQueue20);
	child_storenewQueue20?0;
	goto stop_process
stop_process:}

proctype storenewQueue2(chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
