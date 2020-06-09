



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				do
				:: true -> 
for11:
				od;
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
	do
	:: true -> 
for20:
	od;
	do
	:: true -> 
for30:		do
		:: true -> 
for31:
		od;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
	goto stop_process
stop_process:}

