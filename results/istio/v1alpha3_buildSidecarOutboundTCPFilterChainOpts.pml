



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
TcpLoop:		do
	:: true -> 
for10:		do
		:: true -> 
for11:			
			if
			:: true -> 
				goto TcpLoop
			:: true;
			fi;
			do
			:: true -> 
for12:				
				if
				:: true -> 
					
					if
					:: true -> 
						goto TcpLoop
					fi
				:: true;
				fi
			od
		od
	od;
	goto stop_process
stop_process:}

