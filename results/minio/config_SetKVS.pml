



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
for10:		goto stop_process
	od;
	
	if
	:: true -> 
		do
		:: true -> 
for20:
		od
	fi;
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
	goto stop_process
stop_process:}

