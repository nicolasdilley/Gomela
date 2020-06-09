#define lb_for194_0  -1
#define ub_for194_1  -1
#define lb_for236_2  -1
#define ub_for236_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [GOMAXPROCS_runtime(0)] of {int};
	chan _ch1_in = [GOMAXPROCS_runtime()] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	
	if
	:: true -> 
		
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
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run Anonymous0(_ch0,_ch1);
	
	if
	:: 0 != -1 && GOMAXPROCS_runtime()-1 != -1 -> 
				for(i : 0.. GOMAXPROCS_runtime()-1) {
for20:			run Anonymous1(_ch0,_ch1)
		}
	:: else -> 
		do
		:: true -> 
for20:			run Anonymous1(_ch0,_ch1)
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	
	if
	:: lb_for194_0 != -1 && ub_for194_1 != -1 -> 
				for(i : lb_for194_0.. ub_for194_1) {
for10:			do
			:: true -> 
				goto stop_process
			:: _ch0.in!0 -> 
				_ch0.sending?state;
				break
			od;
			do
			:: true -> 
				goto stop_process
			:: _ch1.in!0 -> 
				_ch1.sending?state;
				break
			od;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				goto stop_process
			:: _ch0.in!0 -> 
				_ch0.sending?state;
				break
			od;
			do
			:: true -> 
				goto stop_process
			:: _ch1.in!0 -> 
				_ch1.sending?state;
				break
			od;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	_ch1.closing!true;
	_ch0.closing!true;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: _ch1.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch1.in?0;
			
			if
			:: lb_for236_2 != -1 && ub_for236_3 != -1 -> 
								for(i : lb_for236_2.. ub_for236_3) {
for22:					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for22:					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for22_exit:
		fi
	od;
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
