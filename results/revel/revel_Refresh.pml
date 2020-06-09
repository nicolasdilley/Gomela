



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
	od;
	do
	:: true -> 
for30:
	od;
	do
	:: true -> 
for40:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
	goto stop_process;
	do
	:: true -> 
for20:
	od
stop_process:}

