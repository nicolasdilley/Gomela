



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
	
	if
	:: true -> 
		do
		:: true -> 
for30:
		od
	:: true;
	fi;
	goto stop_process
stop_process:}

