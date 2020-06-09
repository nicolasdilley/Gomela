



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:		run Anonymous0()
	od;
	
	if
	:: true -> 
		do
		:: true -> 
for20:
		od;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:
}
