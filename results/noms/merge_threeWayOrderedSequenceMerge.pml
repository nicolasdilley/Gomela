#define lb_for34_0  -1
#define ub_for34_1  -1

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
	chan child_mergestopAndDrain23 = [0] of {int};
	chan _ch3_in = [1] of {int};
	chan _ch1_in = [0] of {int};
	chan child_mergestopAndDrain22 = [0] of {int};
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
	run Anonymous2(_ch1,_ch0,_ch3,_ch2);
	do
	:: true -> 
for20:		
		if
		:: true -> 
			_ch1.in?0
		:: true;
		fi;
		
		if
		:: true -> 
			_ch0.in?0
		:: true;
		fi;
		
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
	run mergestopAndDrain2(_ch3,_ch1,child_mergestopAndDrain22);
	child_mergestopAndDrain22?0;
	run mergestopAndDrain2(_ch2,_ch0,child_mergestopAndDrain23);
	child_mergestopAndDrain23?0
stop_process:}

proctype adiff3(Chandef change;Chandef stop;chan child) {
	bool closed; 
	int i;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch1;Chandef _ch0;Chandef _ch3;Chandef _ch2) {
	bool closed; 
	int i;
	chan child_adiff30 = [0] of {int};
	run adiff3(_ch1,_ch3,child_adiff30);
	child_adiff30?0;
	_ch1.closing!true;
stop_process:
}
proctype bdiff3(Chandef change;Chandef stop;chan child) {
	bool closed; 
	int i;
	child!0;
stop_process:
}
proctype Anonymous2(Chandef _ch1;Chandef _ch0;Chandef _ch3;Chandef _ch2) {
	bool closed; 
	int i;
	chan child_bdiff31 = [0] of {int};
	run bdiff3(_ch0,_ch2,child_bdiff31);
	child_bdiff31?0;
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
