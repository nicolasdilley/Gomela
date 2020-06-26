#define lb_for517_0  -1
#define ub_for517_1  -1
#define lb_for529_2  -1
#define ub_for529_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1] of {int};
	chan _ch2_in = [1] of {int};
	bool state = false;
	chan _ch1_in = [1] of {int};
	int i;
	Chandef _ch2;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run Anonymous0(_ch0,ctrlCSignal,ctrlZSignal);
	_ch1.in = _ch1_in;
	run Anonymous1(_ch0,_ch1,ctrlZSignal);
	_ch2.in = _ch2_in;
	run Anonymous2(_ch0,_ch1,_ch2)
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef ctrlCSignal;Chandef ctrlZSignal) {
	bool closed; 
	int i;
	_ch0.in?0;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1;Chandef ctrlZSignal) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		_ch1.in?0
	od;
for10_exit:stop_process:
}
proctype Anonymous2(Chandef _ch0;Chandef _ch1;Chandef _ch2) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		_ch2.in?0
	od;
for20_exit:stop_process:
}
