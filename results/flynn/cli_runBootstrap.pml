
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
	run Anonymous0(_ch0,_ch1);
	
	if
	:: true -> 
		chan child_clirunBootstrapBackup40 = [0] of {int};
		run clirunBootstrapBackup4(_ch0,child_clirunBootstrapBackup40);
		child_clirunBootstrapBackup40?0
	fi;
	_ch1.in?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0
		fi
	od;
	_ch1.closing!true;
stop_process:
}
proctype clirunBootstrapBackup4(Chandef ch;chan child) {
	bool closed; 
	int i;
	
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
	do
	:: true -> 
for20:
	od;
	do
	:: true -> 
for30:		

		if
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		fi
	od;
	do
	:: true -> 
for40:		do
		:: true -> 
for41:
		od
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	ch.in!0;
	ch.sending?state;
	
	if
	:: true -> 
		ch.in!0;
		ch.sending?state;
		goto stop_process
	:: true;
	fi;
	ch.in!0;
	ch.sending?state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	ch.in!0;
	ch.sending?state;
	
	if
	:: true -> 
		ch.in!0;
		ch.sending?state;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	ch.in!0;
	ch.sending?state;
	
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
		ch.in!0;
		ch.sending?state;
		
		if
		:: true -> 
			ch.in!0;
			ch.sending?state;
			goto stop_process
		:: true;
		fi;
		ch.in!0;
		ch.sending?state
	:: true;
	fi;
	
	if
	:: true -> 
		
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
		ch.in!0;
		ch.sending?state;
		
		if
		:: true -> 
			ch.in!0;
			ch.sending?state;
			goto stop_process
		:: true;
		fi;
		ch.in!0;
		ch.sending?state
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
	ch.in!0;
	ch.sending?state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for50:
	od;
	do
	:: true -> 
for60:
	od;
	do
	:: true -> 
for70:		do
		:: true -> 
for71:
		od
	od;
	do
	:: true -> 
for80:		do
		:: true -> 
for81:
		od
	od;
	ch.in!0;
	ch.sending?state;
	
	if
	:: true -> 
		ch.in!0;
		ch.sending?state;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for90:		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
	
	if
	:: true -> 
		
		if
		:: true -> 
			ch.in!0;
			ch.sending?state;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	ch.in!0;
	ch.sending?state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: true -> 
for100:			
			if
			:: true -> 
				break
			:: true;
			fi
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		ch.in!0;
		ch.sending?state;
		ch.in!0;
		ch.sending?state
	:: true;
	fi;
	goto stop_process;
	ch.closing!true;
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
