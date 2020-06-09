



init { 
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
	do
	:: true -> 
for10:
	od;
	do
	:: true -> 
for20:		do
		:: true -> 
for21:			do
			:: true -> 
for22:
			od
		od
	od;
	
	if
	:: true -> 
		do
		:: true -> 
for30:
		od
	fi;
	do
	:: true -> 
for40:
	od;
	goto stop_process
stop_process:}

