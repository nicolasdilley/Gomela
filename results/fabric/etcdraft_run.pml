#define lb_for109_0  -1
#define ub_for109_1  -1
#define lb_for124_2  -1
#define ub_for124_3  -1

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
	
	if
	:: true -> 
		n_chain_snapC.in!0;
		n_chain_snapC.sending?state
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	
	if
	:: true -> 
		run Anonymous0(_ch0)
	:: true;
	fi;
	do
	:: true -> 
for20:		do
		:: true -> 
			break
		:: true -> 
			
			if
			:: true -> 
				n_chain_snapC.in!0;
				n_chain_snapC.sending?state
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					do
					:: notifyLeaderChangeC.in!0 -> 
						notifyLeaderChangeC.sending?state;
						break
					:: true -> 
						break
					od
				:: true;
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				n_chain_applyC.in!0;
				n_chain_applyC.sending?state
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					_ch0.closing!true
				:: true;
				fi
			:: true;
			fi;
			break
		:: true -> 
			break
		:: true -> 
			n_chain_doneC.closing!true;
			goto stop_process
		od
	od;
for20_exit:
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
			break
		:: _ch0.in?0 -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:stop_process:
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
