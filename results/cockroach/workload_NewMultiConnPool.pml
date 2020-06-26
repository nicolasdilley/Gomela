
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [100] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: true -> 
for11:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		od
	od;
	_ch0.in = _ch0_in;
	do
	:: true -> 
for20:		do
		:: true -> 
for21:			_ch0.in!0
		od
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for30:		do
		:: true -> 
for31:
		od
	od;
	goto stop_process
stop_process:}

