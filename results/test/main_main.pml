
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_mainTest10 = [0] of {int};
	chan _ch0_in = [0] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run mainTest1(_ch0,child_mainTest10);
	child_mainTest10?0
stop_process:}

proctype go_mainRoutine1(Chandef a) {
	bool closed; 
	int i;
	a.in!0;
stop_process:
}
proctype mainTest1(Chandef a;chan child) {
	bool closed; 
	int i;
		for(i : 0.. b-1) {
for10:		run go_mainRoutine1(a);
		a.in?0
	};
for10_exit:	child!0;
stop_process:
}
