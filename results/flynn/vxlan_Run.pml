#define lb_for123_0  -1
#define ub_for123_1  -1

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
	run Anonymous0(evts);
	_ch0.in = _ch0_in;
	run Anonymous1(_ch0);
	do
	:: true -> 
for10:		do
		:: _ch0.in?0 -> 
			break
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:
stop_process:}

proctype Anonymous0(Chandef evts) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1(Chandef _ch0) {
	bool closed; 
	int i;
stop_process:
}
