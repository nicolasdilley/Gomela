



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		do
		:: true -> 
for10:			do
			:: true -> 
for11:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				do
				:: true -> 
for12:
				od
			od
		od;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for20:		do
		:: true -> 
for21:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
for22:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			od
		od
	od
stop_process:}

