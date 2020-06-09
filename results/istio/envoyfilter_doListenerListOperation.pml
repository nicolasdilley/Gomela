



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:
	od;
	
	if
	:: true -> 
		do
		:: true -> 
for20:
		od
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for30:
		od;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

