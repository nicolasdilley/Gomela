



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for20:
	od;
	do
	:: true -> 
for30:		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for40:		do
		:: true -> 
for41:
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

