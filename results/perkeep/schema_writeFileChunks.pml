#define lb_for331_0  -1
#define ub_for331_1  -1
#define lb_for374_2  -1
#define ub_for374_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	do
	:: true -> 
for10:		
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
			break
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		fi;
		
		if
		:: lb_for374_2 != -1 && ub_for374_3 != -1 -> 
						for(i : lb_for374_2.. ub_for374_3) {
for11:
			}
		:: else -> 
			do
			:: true -> 
for11:
			:: true -> 
				break
			od
		fi;
for11_exit:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for10_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 0 != -1 && chunksInFlight-1 != -1 -> 
				for(i : 0.. chunksInFlight-1) {
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
for20_exit:	do
	:: _ch0.in?0 -> 
		goto stop_process
	:: true -> 
		break
	od;
	goto stop_process
stop_process:}

