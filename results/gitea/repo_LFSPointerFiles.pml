#define lb_for627_0  -1
#define ub_for627_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [1] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	
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
	run go_repocreatePointerResultsFromCatFileBatch5(_ch0);
	
	if
	:: true -> 
		run go_pipelineRevListAllObjects4(_ch1)
	:: true -> 
		run go_pipelineCatFileBatchCheckAllObjects4(_ch1)
	fi;
	do
	:: _ch1.in?0 -> 
		break
	:: true -> 
		break
	od
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
stop_process:
}
proctype go_repocreatePointerResultsFromCatFileBatch5(Chandef pointerChan) {
	bool closed; 
	int i;
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
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				break
			:: true;
			fi
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi
			fi
		:: true;
		fi;
		pointerChan.in!0;
		pointerChan.sending?state
	od;
for20_exit:	pointerChan.closing!true;
stop_process:
}
proctype go_pipelineRevListAllObjects4(Chandef errChan) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		errChan.in!0;
		errChan.sending?state
	:: true;
	fi;
stop_process:
}
proctype go_pipelineCatFileBatchCheckAllObjects4(Chandef errChan) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		errChan.in!0;
		errChan.sending?state
	:: true;
	fi;
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
