#define lb_for193_0  -1
#define ub_for193_1  -1

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
	do
	:: true -> 
for10:
	od;
	_ch0.in = _ch0_in;
	do
	:: true -> 
for20:		do
		:: true -> 
			break
		:: true -> 
			break
		:: ctl_state.in!0 -> 
			break
		:: _ch0.in?0 -> 
			goto stop_process
		od
	od;
for20_exit:
stop_process:}

