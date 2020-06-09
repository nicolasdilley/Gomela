



init { 
	bool state = false;
	int i;
	
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
			do
			:: true -> 
for10:				
				if
				:: true -> 
					run Anonymous0()
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				fi
			od;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			do
			:: true -> 
for20:				do
				:: true -> 
for21:
				od;
				run Anonymous1()
			od;
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
stop_process:
}
