#define lb_for85_0  -1
#define ub_for85_1  -1

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
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0;
			
			if
			:: true -> 
				break
			:: true;
			fi
		fi
	od;
	do
	:: true -> 
for20:		goto stop_process
	od;
for20_exit:
stop_process:}

