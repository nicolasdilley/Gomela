



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:
	od;
	do
	:: true -> 
for20:
	od;
	do
	:: true -> 
for30:
	od;
	
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
for40:		do
		:: true -> 
			break
		:: true -> 
			break
		od
	od
stop_process:}

