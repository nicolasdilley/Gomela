
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	_ch0.in = _ch0_in;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
	
	if
	:: 0 != -1 && isLiveMap-1 != -1 -> 
				for(i : 0.. isLiveMap-1) {
for20:			do
			:: _ch0.in?0 -> 
				do
				:: true -> 
for21:
				od;
				break
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: _ch0.in?0 -> 
				do
				:: true -> 
for21:
				od;
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

