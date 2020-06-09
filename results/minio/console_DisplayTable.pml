



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
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
	do
	:: true -> 
for30:
	od;
	do
	:: true -> 
for40:		do
		:: true -> 
for41:
		od
	od;
	goto stop_process
stop_process:}

