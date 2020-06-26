#define lb_for232_0  -1
#define ub_for232_1  -1
#define lb_for158_2  -1
#define ub_for158_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	chan _ch3_in = [0] of {int};
	bool state = false;
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch3;
	Chandef _ch1;
	Chandef _ch0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run go_panicwraptrackPanic4(_ch1);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch3.in = _ch3_in;
	run chanMonitor(_ch3);
	run Anonymous1(_ch0,_ch1,_ch3);
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		_ch1.in?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	_ch1.in?0;
	_ch0.closing!true
stop_process:}

proctype go_panicwraptrackPanic4(Chandef result) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					result.in!0;
					result.sending?state
				:: true;
				fi;
				goto stop_process
			:: true;
			fi
		fi;
		
		if
		:: true -> 
			do
			:: true -> 
				break
			:: true -> 
				break
			od
		:: true;
		fi;
		do
		:: true -> 
for11:			
			if
			:: true -> 
				break
			:: true;
			fi
		od
	od;
for10_exit:	result.closing!true;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1;Chandef _ch3) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: _ch0.in?0 -> 
			goto stop_process
		:: _ch3.in?0 -> 
			break
		od
	od;
for20_exit:stop_process:
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
