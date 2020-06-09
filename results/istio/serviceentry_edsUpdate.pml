



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:
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
		do
		:: true -> 
for30:
		od;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for40:
	od;
	do
	:: true -> 
for50:
	od
stop_process:}

