



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	do
	:: true -> 
for10:
	od;
	goto stop_process
stop_process:}

