
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous0(_ch0);
	goto stop_process
stop_process:}

proctype dirwalk2(Chandef c;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			c.in!0;
			c.sending?state
		:: true;
		fi;
		do
		:: true -> 
for10:			chan child_dwalk21 = [0] of {int};
			run dwalk2(child_dwalk21);
			child_dwalk21?0
		od
	:: true;
	fi;
	child!0;
stop_process:
}
proctype dwalk2(chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			c.in!0;
			c.sending?state
		:: true;
		fi;
		do
		:: true -> 
for11:			chan child_dwalk20 = [0] of {int};
			run dwalk2(child_dwalk20);
			child_dwalk20?0
		od
	:: true;
	fi;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	chan child_dirwalk22 = [0] of {int};
	run dirwalk2(_ch0,child_dirwalk22);
	child_dirwalk22?0;
	_ch0.closing!true;
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
