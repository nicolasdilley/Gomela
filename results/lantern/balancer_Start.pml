#define lb_for74_0  -1
#define ub_for74_1  -1

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
	run Anonymous0(_ch0)
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
		for(i : lb_for74_0.. ub_for74_1) {
for10:		do
		:: _ch0.in?0 -> 
			goto stop_process
		:: true -> 
			break
		od
	};
for10_exit:stop_process:
}
