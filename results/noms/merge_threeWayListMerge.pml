#define lb_for54_0  -1
#define ub_for54_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch2_in = [1] of {int};
	chan child_mergestopAndDrain21 = [0] of {int};
	chan _ch3_in = [1] of {int};
	chan _ch1_in = [0] of {int};
	chan child_mergestopAndDrain20 = [0] of {int};
	int i;
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
	run Anonymous0(_ch1,_ch0,_ch3,_ch2);
	run Anonymous1(_ch1,_ch0,_ch3,_ch2);
	do
	:: true -> 
for20:		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for20_exit:	goto stop_process;
	run mergestopAndDrain2(_ch3,_ch1,child_mergestopAndDrain20);
	child_mergestopAndDrain20?0;
	run mergestopAndDrain2(_ch2,_ch0,child_mergestopAndDrain21);
	child_mergestopAndDrain21?0
stop_process:}

proctype Anonymous0(Chandef _ch1;Chandef _ch0;Chandef _ch3;Chandef _ch2) {
	bool closed; 
	int i;
	_ch1.closing!true;
stop_process:
}
proctype Anonymous1(Chandef _ch1;Chandef _ch0;Chandef _ch3;Chandef _ch2) {
	bool closed; 
	int i;
	_ch0.closing!true;
stop_process:
}
proctype mergestopAndDrain2(Chandef stop;Chandef drain;chan child) {
	bool closed; 
	int i;
	stop.closing!true;
	do
	:: true -> 
for10:
	od;
	child!0;
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
