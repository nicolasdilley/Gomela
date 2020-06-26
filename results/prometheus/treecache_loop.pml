#define lb_for151_0  -1
#define ub_for151_1  -1

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
for10:		do
		:: true -> 
			
			if
			:: true -> 
								for(i : 1.. parts) {
for11:
				}
			fi;
			break
		:: _ch0.in?0 -> 
			break
		:: true -> 
			tc_head_done.in!0;
			goto stop_process
		od
	od;
for10_exit:
stop_process:}

