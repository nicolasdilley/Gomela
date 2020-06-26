#define lb_for81_0  -1
#define ub_for81_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch4_in = [0] of {int};
	chan _ch0_in = [0] of {int};
	chan _ch2_in = [0] of {int};
	bool state = false;
	chan _ch3_in = [0] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch4;
	Chandef _ch3;
	Chandef _ch2;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
	_ch3.in = _ch3_in;
	run chanMonitor(_ch3);
	_ch4.in = _ch4_in;
	run chanMonitor(_ch4);
	run Anonymous0(_ch0,_ch1,_ch2,_ch3,_ch4);
	
	if
	:: true -> 
		run Anonymous1(_ch0,_ch1,_ch2,_ch3,_ch4)
	:: true;
	fi
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef _ch4) {
	bool closed; 
	int i;
	_ch4.closing!true;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef _ch4) {
	bool closed; 
	int i;
	do
	:: _ch4.in?0 -> 
		goto stop_process
	:: true -> 
		do
		:: true -> 
for10:
		od;
for10_exit:		goto stop_process
	:: true -> 
		break
	od;
stop_process:
}
proctype chanMonitor(Chandef ch) {
	bool closed; 
	int i;
	state = false;
	do
	:: true -> 
		if
		:: state -> 
end:			if
			:: ch.sending!state -> 
				assert(false)
			:: ch.closing?true -> 
				assert(false)
			:: ch.in!0;
			:: ch.is_closed!state;
			fi
		:: else -> 
end1:			if
			:: ch.sending!state;
			:: ch.closing?true -> 
				state = true
			:: ch.is_closed!state;
			fi
		fi
	od;
stop_process:
}
