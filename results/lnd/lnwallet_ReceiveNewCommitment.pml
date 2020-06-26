#define verifyJobs  ??

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_lc_sigPoolSubmitVerifyBatch20 = [0] of {int};
	chan _ch0_in = [0] of {int};
	int i;
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
	run lc_sigPoolSubmitVerifyBatch2(_ch0,verifyJobs,child_lc_sigPoolSubmitVerifyBatch20);
	child_lc_sigPoolSubmitVerifyBatch20?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		_ch0.closing!true;
		goto stop_process
	:: true;
	fi;
	
	if
	:: 0 != -1 && verifyJobs-1 != -1 -> 
				for(i : 0.. verifyJobs-1) {
for20:			
			if
			:: true -> 
				_ch0.closing!true;
				
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
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: true -> 
				_ch0.closing!true;
				
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
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype lc_sigPoolSubmitVerifyBatch2(Chandef cancelChan;int verifyJobs _1;chan child) {
	bool closed; 
	int i;
	Chandef _ch1;
	chan _ch1_in = [verifyJobs _1] of {int};
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	do
	:: true -> 
for10:		do
		:: s_verifyJobs.in!0 -> 
			s_verifyJobs.sending?state;
			break
		:: true -> 
			goto stop_process
		od
	od;
	goto stop_process;
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
