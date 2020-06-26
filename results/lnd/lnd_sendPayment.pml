#define lb_for4113_0  -1
#define ub_for4113_1  -1
#define lb_for4177_2  -1
#define ub_for4177_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch2_in = [numOutstandingPayments] of {int};
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch3_in = [0] of {int};
	chan _ch1_in = [1] of {int};
	int i;
	Chandef _ch3;
	Chandef _ch2;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
	
	if
	:: 0 != -1 && numOutstandingPayments-1 != -1 -> 
				for(i : 0.. numOutstandingPayments-1) {
for10:			_ch2.in!0;
			_ch2.sending?state
		}
	:: else -> 
		do
		:: true -> 
for10:			_ch2.in!0;
			_ch2.sending?state
		:: true -> 
			break
		od
	fi;
for10_exit:	_ch3.in = _ch3_in;
	run chanMonitor(_ch3);
	run Anonymous0(_ch0,_ch1,_ch2,_ch3);
sendLoop:			for(i : lb_for4177_2.. ub_for4177_3) {
for30:		do
		:: _ch1.in?0 -> 
			goto stop_process
		:: true -> 
			goto stop_process
		:: _ch0.in?0 -> 
			
			if
			:: true -> 
				goto sendLoop
			:: true;
			fi;
			run Anonymous1(_ch0,_ch1,_ch2,_ch3);
			break
		od
	};
for30_exit:;
	goto stop_process;
	_ch3.closing!true
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: _ch3.in?0 -> 
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				_ch0.closing!true;
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					do
					:: _ch1.in!0 -> 
						_ch1.sending?state;
						break
					:: true -> 
						break
					od;
					goto stop_process
				:: true;
				fi
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					do
					:: _ch1.in!0 -> 
						_ch1.sending?state;
						break
					:: true -> 
						break
					od;
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			do
			:: _ch0.in!0 -> 
				_ch0.sending?state;
				break
			:: _ch3.in?0 -> 
				goto stop_process
			od;
			break
		od
	od;
for20_exit:stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3) {
	bool closed; 
	int i;
	do
	:: _ch2.in?0 -> 
		break
	:: _ch3.in?0 -> 
		goto stop_process
	od;
	

	if
	:: true -> 
		do
		:: errChan.in!0 -> 
			errChan.sending?state;
			break
		:: true -> 
			break
		od;
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			do
			:: errChan.in!0 -> 
				errChan.sending?state;
				break
			:: true -> 
				break
			od
		:: true;
		fi;
		goto stop_process
	fi;
	
	if
	:: true -> 
		_ch1.in!0;
		_ch1.sending?state;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: _ch1.in!0 -> 
			_ch1.sending?state;
			break
		:: true -> 
			break
		od;
		goto stop_process
	:: true;
	fi;
	_ch2.in!0;
	_ch2.sending?state;
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
