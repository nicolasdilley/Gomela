



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
for11:
		od
	od;
	do
	:: true -> 
for20:		do
		:: true -> 
for21:
		od
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for30:
	od;
	goto stop_process
stop_process:}

