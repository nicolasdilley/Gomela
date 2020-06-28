#define lb_for121_0  -1
#define ub_for121_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
		for(i : lb_for121_0.. ub_for121_1) {
for10:		run Anonymous0(_ch0)
	};
for10_exit:
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
stop_process:
}
