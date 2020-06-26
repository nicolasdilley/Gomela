
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [fs.Config.Transfers] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	
	if
	:: 0 != -1 && fs.Config.Transfers-1 != -1 -> 
				for(i : 0.. fs.Config.Transfers-1) {
for10:			_ch0.in!0
		}
	:: else -> 
		do
		:: true -> 
for10:			_ch0.in!0
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

