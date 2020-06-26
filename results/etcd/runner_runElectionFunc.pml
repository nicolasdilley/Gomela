#define lb_for67_0  -1
#define ub_for67_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [rcs] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
		for(i : 1.. rcs) {
for10:		do
		:: true -> 
for11:			
			if
			:: true -> 
				break
			:: true;
			fi
		od;
for11_exit:
	}
stop_process:}

