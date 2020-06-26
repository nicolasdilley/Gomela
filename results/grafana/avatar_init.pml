#define lb_for162_0  -1
#define ub_for162_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [t.QueueSize] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
		for(i : 0.. t.QueueSize-1) {
for10:		run Anonymous0(_ch0)
	};
for10_exit:
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		_ch0.in?0
	od;
for11_exit:stop_process:
}
