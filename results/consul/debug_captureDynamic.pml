#define lb_for528_0  -1
#define ub_for528_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
		for(i : lb_for528_0.. ub_for528_1) {
for10:		do
		:: _ch0.in?0 -> 
			break
		:: _ch1.in?0 -> 
			break
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od
	};
for10_exit:
stop_process:}

