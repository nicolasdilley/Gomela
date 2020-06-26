#define lb_for48_0  -1
#define ub_for48_1  -1

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
	_ch0.in = _ch0_in;
	do
	:: true -> 
for20:		do
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		:: true -> 
			break
		:: _ch0.in?0 -> 
			break
		od
	od;
for20_exit:	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od
stop_process:}

