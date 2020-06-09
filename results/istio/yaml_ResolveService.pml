



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
for11:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		od
	od;
	goto stop_process
stop_process:}

