
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
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
	:: true -> 
		Chandef _ch0;
		chan _ch0_in = [k.precomputeCount] of {int};
		_ch0.in = _ch0_in
	fi;
	goto stop_process
stop_process:}

