#define lb_for168_0  -1
#define ub_for168_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for168_0 != -1 && ub_for168_1 != -1 -> 
				for(i : lb_for168_0.. ub_for168_1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
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
	:: 0 != -1 && NumField_rt()-1 != -1 -> 
				for(i : 0.. NumField_rt()-1) {
for20:			
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
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
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
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

