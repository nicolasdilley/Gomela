#define lb_for45_0  -1
#define ub_for45_1  -1

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
	run Anonymous0(_ch0);
	do
	:: _ch0.in?0 -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			_ch0.in!0;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			_ch0.in!0;
			goto stop_process
		:: true;
		fi
	od;
for10_exit:stop_process:
}
