#define len_files_0  5

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [len_files_0] of {int};
	bool closed = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
		for(i : 1.. len_files_0) {
for10:		run go_mainworker3(_ch0);
		run go_mainworker3(_ch0);
		chan child_mainworker30 = [0] of {int};
		run mainworker3(_ch0,child_mainworker30);
		child_mainworker30?0
	};
for10_exit:		for(i : 1.. len_files_0) {
for20:		_ch0.in?0
	};
for20_exit:
stop_process:}

proctype go_mainworker3(Chandef a) {
	bool closed; 
	int i;
	a.in!0;
stop_process:
}
proctype mainworker3(Chandef a;chan child) {
	bool closed; 
	int i;
	a.in!0;
	child!0;
stop_process:
}
