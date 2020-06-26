
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [1] of {int};
	chan _ch1_in = [1] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	do
	:: f_queries.in!0 -> 
		break
	:: true -> 
		goto stop_process
	od;
	do
	:: _ch0.in?0 -> 
		goto stop_process
	:: _ch1.in?0 -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od
stop_process:}

