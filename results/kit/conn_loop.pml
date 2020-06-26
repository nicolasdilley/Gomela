#define lb_for98_0  -1
#define ub_for98_1  -1

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
	_ch0.in!0;
		for(i : lb_for98_0.. ub_for98_1) {
for10:		do
		:: true -> 
			run Anonymous0();
			break
		:: true -> 
			break
		:: m_takec.in!0 -> 
			break
		:: true -> 
			break
		od
	};
for10_exit:
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	_ch0.in!0;
stop_process:
}
