#define lb_for915_0  -1
#define ub_for915_1  -1
#define lb_for920_2  -1
#define ub_for920_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [1024] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	run go_tikvrpcCheckStreamTimeoutLoop2(_ch0,_ch1);
	goto stop_process
stop_process:}

proctype go_tikvrpcCheckStreamTimeoutLoop2(Chandef ch;Chandef done) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: done.in?0 -> 
drainLoop:						do
			:: true -> 
for11:				do
				:: ch.in?0 -> 
					break
				:: true -> 
					goto drainLoop;
					break
				od
			od;
for11_exit:;
			goto stop_process
		:: ch.in?0 -> 
			break
		:: true -> 
			break
		od
	od;
for10_exit:stop_process:
}
