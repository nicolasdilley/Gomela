#define lb_for207_0  -1
#define ub_for207_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch2_in = [existing] of {int};
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch3_in = [existing] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch3;
	Chandef _ch2;
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
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
	_ch3.in = _ch3_in;
	run chanMonitor(_ch3);
		for(i : 0.. consts.ExpirationRestoreWorkerCount-1) {
for10:		run Anonymous0(_ch0,_ch1,_ch2,_ch3)
	};
for10_exit:	run Anonymous1(_ch0,_ch1,_ch2,_ch3);
	
	if
	:: 0 != -1 && existing-1 != -1 -> 
				for(i : 0.. existing-1) {
for30:			do
			:: _ch2.in?0 -> 
				_ch1.closing!true;
				goto stop_process
			:: _ch3.in?0 -> 
				do
				:: true -> 
for31:					
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
							
							if
							:: true -> 
								goto stop_process
							:: true;
							fi
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
					fi
				od;
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for30:			do
			:: _ch2.in?0 -> 
				_ch1.closing!true;
				goto stop_process
			:: _ch3.in?0 -> 
				do
				:: true -> 
for31:					
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
							
							if
							:: true -> 
								goto stop_process
							:: true;
							fi
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
					fi
				od;
				break
			od
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		do
		:: _ch0.in?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				_ch2.in!0;
				_ch2.sending?state
			:: true;
			fi;
			_ch3.in!0;
			_ch3.sending?state;
			break
		:: _ch1.in?0 -> 
			goto stop_process
		od
	od;
for11_exit:stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: _ch1.in?0 -> 
			goto stop_process
		:: true -> 
			_ch0.in!0;
			_ch0.sending?state;
			break
		od
	od;
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
