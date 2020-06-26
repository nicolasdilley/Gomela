
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [parallelNum] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	

	if
	:: true;
	:: true;
	:: true;
	fi;
	_ch0.in = _ch0_in;
		for(i : 1.. p.tasks) {
for10:		_ch0.in!0;
		do
		:: true -> 
			goto stop_process
		:: true -> 
			run Anonymous0(_ch0);
			break
		od
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in?0;
stop_process:
}
