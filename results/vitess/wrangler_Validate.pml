
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_wrwaitForResults25 = [0] of {int};
	chan _ch0_in = [16] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous0(_ch0);
	
	if
	:: true -> 
		_ch0.in!0;
		_ch0.sending?state
	:: true -> 
				for(i : 1.. keyspaces) {
for30:			run Anonymous3(_ch0)
		}
	fi;
	run wrwaitForResults2(_ch0,child_wrwaitForResults25);
	child_wrwaitForResults25?0;
	goto stop_process
stop_process:}

proctype wrvalidateAllTablets3(Chandef results;chan child) {
	bool closed; 
	int i;
	
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
			results.sending?state;
			goto stop_process
		:: true;
		fi;
		do
		:: true -> 
for11:			
			if
			:: true -> 
				results.in!0;
				results.sending?state;
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
for12:
			od
		od
	od;
		for(i : 1.. cellSet) {
for20:		
		if
		:: true -> 
			results.in!0;
			results.sending?state
		:: true;
		fi;
				for(i : 1.. aliases) {
for21:			run Anonymous1(results,results)
		}
	};
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
proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	chan child_wrvalidateAllTablets30 = [0] of {int};
	run wrvalidateAllTablets3(_ch0,child_wrvalidateAllTablets30);
	child_wrvalidateAllTablets30?0;
stop_process:
}
proctype wrvalidateKeyspace5(Chandef results;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		results.in!0;
		results.sending?state;
		goto stop_process
	:: true;
	fi;
		for(i : 1.. shards) {
for31:		run Anonymous4(results,results)
	};
	child!0;
stop_process:
}
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
for32:		
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
for33:		run Anonymous5(results,results)
	};
	
	if
	:: true -> 
		chan child_wrvalidateReplication41 = [0] of {int};
		run wrvalidateReplication4(results,child_wrvalidateReplication41);
		child_wrvalidateReplication41?0;
		chan child_wrpingTablets42 = [0] of {int};
		run wrpingTablets4(results,child_wrpingTablets42);
		child_wrpingTablets42?0
	:: true;
	fi;
	child!0;
stop_process:
}
proctype Anonymous5(Chandef results;Chandef results) {
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
for34:		
		if
		:: true -> 
			results.in!0;
			results.sending?state
		:: true;
		fi
	od;
	do
	:: true -> 
for35:		
		if
		:: true -> 
			results.in!0;
			results.sending?state
		:: true;
		fi
	od;
	do
	:: true -> 
for36:		
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
for37:		run Anonymous8(results,results)
	};
	child!0;
stop_process:
}
proctype Anonymous8(Chandef results;Chandef results) {
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
proctype Anonymous4(Chandef results;Chandef results) {
	bool closed; 
	int i;
	chan child_wrvalidateShard63 = [0] of {int};
	run wrvalidateShard6(results,child_wrvalidateShard63);
	child_wrvalidateShard63?0;
stop_process:
}
proctype Anonymous3(Chandef _ch0) {
	bool closed; 
	int i;
	chan child_wrvalidateKeyspace54 = [0] of {int};
	run wrvalidateKeyspace5(_ch0,child_wrvalidateKeyspace54);
	child_wrvalidateKeyspace54?0;
stop_process:
}
proctype wrwaitForResults2(Chandef results;chan child) {
	bool closed; 
	int i;
	run Anonymous12(results,results);
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
proctype Anonymous12(Chandef results;Chandef results) {
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
