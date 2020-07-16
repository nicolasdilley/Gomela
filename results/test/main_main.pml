
// /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/source/test/test.go
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_mainb21 = [0] of {int};
	chan _ch0_in = [a] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run mainb2(_ch0,child_mainb21);
	child_mainb21?0
stop_process:}

proctype mainb2(Chandef ch2;chan child) {
	bool closed; 
	int i;
	chan child_mainc20 = [0] of {int};
	run mainc2(ch2,ch2,child_mainc20);
	child_mainc20?0;
	ch2.in!0;
	child!0;
stop_process:
}
proctype mainc2(Chandef ch1;int i;chan child) {
	bool closed; 
	int i;
	Chandef _ch1;
	chan _ch1_in = [i] of {int};
	_ch1.in = _ch1_in;
	ch1.in!0;
	child!0;
stop_process:
}
