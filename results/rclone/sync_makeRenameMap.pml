
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [fs.Config.Checkers] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	do
	:: true -> 
for10:
	od;
	_ch0.in = _ch0_in;
		for(i : 0.. fs.Config.Transfers-1) {
for20:		run Anonymous0(_ch0)
	};
for20_exit:
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0
		fi
	od;
stop_process:
}
