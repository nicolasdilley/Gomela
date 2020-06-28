
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [64] of {int};
	chan _ch1_in = [workers] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	
	if
	:: true -> 
		

		if
		:: true;
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
		for(i : 0.. workers-1) {
for10:		run go_spellcheckworker5(_ch0,_ch1)
	};
for10_exit:	do
	:: true -> 
for20:
	od;
	_ch0.closing!true;
	goto stop_process
stop_process:}

proctype go_spellcheckworker5(Chandef files;Chandef results) {
	bool closed; 
	int i;
	do
	:: files.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			files.in?0;
			do
			:: true -> 
for12:
			od
		fi
	od;
	results.in!0;
	results.sending?state;
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
