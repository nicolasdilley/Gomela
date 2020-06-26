#define uniqueURLs  ??

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [maxConcurrentRequests] of {int};
	chan _ch1_in = [uniqueURLs] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	do
	:: true -> 
for10:		_ch0.in!0;
		run Anonymous0(_ch0,_ch1)
	od;
	
	if
	:: 0 != -1 && uniqueURLs-1 != -1 -> 
				for(i : 0.. uniqueURLs-1) {
for20:			_ch1.in?0
		}
	:: else -> 
		do
		:: true -> 
for20:			_ch1.in?0
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: true -> 
		do
		:: true -> 
for30:
		od;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		do
		:: true -> 
for11:
		od;
		_ch1.in!0
	:: true -> 
		_ch1.in!0
	fi;
	_ch0.in?0;
stop_process:
}
