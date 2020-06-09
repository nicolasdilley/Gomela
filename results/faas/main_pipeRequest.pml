



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0();
	
	if
	:: true -> 
		run Anonymous1()
	:: true -> 
		run Anonymous2()
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous2() {
	bool closed; 
	int i;
stop_process:
}
