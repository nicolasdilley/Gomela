
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [batches] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	do
	:: true -> 
for10:
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for20:
	od;
	_ch0.in = _ch0_in;
	do
	:: true -> 
for30:		run Anonymous0(_ch0)
	od;
	
	if
	:: 0 != -1 && batches-1 != -1 -> 
				for(i : 0.. batches-1) {
for40:			_ch0.in?0
		}
	:: else -> 
		do
		:: true -> 
for40:			_ch0.in?0
		:: true -> 
			break
		od
	fi;
for40_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in!0;
stop_process:
}
