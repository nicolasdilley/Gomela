
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	run Anonymous0(_ch0,_ch1);
	run Anonymous2(_ch0,_ch1)
stop_process:}

proctype sccnewInProcStream2(Chandef recv;Chandef send;chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	chan child_sccnewInProcStream20 = [0] of {int};
	run sccnewInProcStream2(_ch0,_ch1,child_sccnewInProcStream20);
	child_sccnewInProcStream20?0;
stop_process:
}
proctype Anonymous2(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	chan child_sccnewInProcStream21 = [0] of {int};
	run sccnewInProcStream2(_ch1,_ch0,child_sccnewInProcStream21);
	child_sccnewInProcStream21?0;
stop_process:
}
