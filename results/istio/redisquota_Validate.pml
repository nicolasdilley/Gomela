



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
for20:
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
	goto stop_process
stop_process:}

