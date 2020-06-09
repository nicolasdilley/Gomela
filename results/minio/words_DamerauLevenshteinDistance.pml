#define a  -1
#define b  -1




init { 
	bool state = false;
	int i;
	
	if
	:: 1 != -1 && len(a) + 1 != -1 -> 
				for(i : 1.. len(a) + 1) {
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
	:: 0 != -1 && len() != -1 -> 
				for(i : 0.. len()) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: 0 != -1 && len() != -1 -> 
				for(i : 0.. len()) {
for30:
		}
	:: else -> 
		do
		:: true -> 
for30:
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: 1 != -1 && len() != -1 -> 
				for(i : 1.. len()) {
for40:			
			if
			:: 1 != -1 && len() != -1 -> 
								for(i : 1.. len()) {
for41:
				}
			:: else -> 
				do
				:: true -> 
for41:
				:: true -> 
					break
				od
			fi;
for41_exit:
		}
	:: else -> 
		do
		:: true -> 
for40:			
			if
			:: 1 != -1 && len() != -1 -> 
								for(i : 1.. len()) {
for41:
				}
			:: else -> 
				do
				:: true -> 
for41:
				:: true -> 
					break
				od
			fi;
for41_exit:
		:: true -> 
			break
		od
	fi;
for40_exit:	goto stop_process
stop_process:}

