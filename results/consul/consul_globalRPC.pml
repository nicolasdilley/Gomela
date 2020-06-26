#define lb_for659_0  -1
#define ub_for659_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [total] of {int};
	chan _ch1_in = [total] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	do
	:: true -> 
for10:		run Anonymous0(_ch0,_ch1)
	od;
	
	if
	:: lb_for659_0 != -1 && ub_for659_1 != -1 -> 
				for(i : lb_for659_0.. ub_for659_1) {
for20:			do
			:: _ch0.in?0 -> 
				goto stop_process
			:: _ch1.in?0 -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: _ch0.in?0 -> 
				goto stop_process
			:: _ch1.in?0 -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		_ch0.in!0;
		goto stop_process
	:: true;
	fi;
	_ch1.in!0;
stop_process:
}
