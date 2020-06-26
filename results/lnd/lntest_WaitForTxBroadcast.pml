
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
		goto stop_process
	:: true -> 
		break
	od;
	_ch0.in = _ch0_in;
	n_bitcoinWatchRequests.in!0;
	do
	:: _ch0.in?0 -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od
stop_process:}

