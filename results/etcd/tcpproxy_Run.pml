#define lb_for91_0  -1
#define ub_for91_1  -1

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
for10:
	od;
	do
	:: true -> 
for20:
	od;
		for(i : lb_for91_0.. ub_for91_1) {
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
for30_exit:
stop_process:}

