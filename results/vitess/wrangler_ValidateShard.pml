
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_wrwaitForResults23 = [0] of {int};
	chan _ch0_in = [16] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous0(_ch0);
	run wrwaitForResults2(_ch0,child_wrwaitForResults23);
	child_wrwaitForResults23?0;
	goto stop_process
stop_process:}

proctype wrvalidateShard6(Chandef results;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		results.in!0;
		results.sending?state;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		results.in!0;
		results.sending?state;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			results.in!0;
			results.sending?state
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				results.in!0;
				results.sending?state
			fi
		:: true;
		fi
	od;
	
	if
	:: true -> 
		results.in!0;
		results.sending?state
	:: true -> 
		
		if
		:: true -> 
			results.in!0;
			results.sending?state
		:: true;
		fi
	fi;
		for(i : 1.. aliases) {
for20:		run Anonymous1(results,results)
	};
	
	if
	:: true -> 
		chan child_wrvalidateReplication40 = [0] of {int};
		run wrvalidateReplication4(results,child_wrvalidateReplication40);
		child_wrvalidateReplication40?0;
		chan child_wrpingTablets41 = [0] of {int};
		run wrpingTablets4(results,child_wrpingTablets41);
		child_wrpingTablets41?0
	:: true;
	fi;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef results;Chandef results) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		results.in!0;
		results.sending?state
	fi;
stop_process:
}
proctype wrvalidateReplication4(Chandef results;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		results.in!0;
		results.sending?state;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		results.in!0;
		results.sending?state;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		results.in!0;
		results.sending?state;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		results.in!0;
		results.sending?state;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for30:		
		if
		:: true -> 
			results.in!0;
			results.sending?state
		:: true;
		fi
	od;
	do
	:: true -> 
for40:		
		if
		:: true -> 
			results.in!0;
			results.sending?state
		:: true;
		fi
	od;
	do
	:: true -> 
for50:		
		if
		:: true -> 
			results.in!0;
			results.sending?state
		:: true;
		fi;
		
		if
		:: true -> 
			results.in!0;
			results.sending?state
		:: true;
		fi
	od;
	child!0;
stop_process:
}
proctype wrpingTablets4(Chandef results;chan child) {
	bool closed; 
	int i;
		for(i : 1.. tabletMap) {
for60:		run Anonymous4(results,results)
	};
	child!0;
stop_process:
}
proctype Anonymous4(Chandef results;Chandef results) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		results.in!0;
		results.sending?state
	:: true;
	fi;
stop_process:
}
proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	chan child_wrvalidateShard62 = [0] of {int};
	run wrvalidateShard6(_ch0,child_wrvalidateShard62);
	child_wrvalidateShard62?0;
stop_process:
}
proctype wrwaitForResults2(Chandef results;chan child) {
	bool closed; 
	int i;
	run Anonymous7(results,results);
	do
	:: results.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			results.in?0
		fi
	od;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous7(Chandef results;Chandef results) {
	bool closed; 
	int i;
	results.closing!true;
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
