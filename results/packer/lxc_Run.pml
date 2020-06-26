#define lb_for71_0  -1
#define ub_for71_1  -1
#define lb_for35_2  -1
#define ub_for35_3  -1

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
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run Anonymous0(_ch0,_ch1);
WaitLoop:		do
	:: true -> 
for20:		do
		:: _ch1.in?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto WaitLoop;
			break
		:: true -> 
			_ch0.closing!true;
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				_ch0.closing!true;
				goto stop_process
			:: true;
			fi;
			break
		od
	od;
for20_exit:;
	goto stop_process
stop_process:}

proctype swaitForInit2(Chandef cancel;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
			goto stop_process
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			break
		:: true -> 
			
			if
			:: true -> 
				break
			:: true;
			fi
		fi
	od;
for10_exit:	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	chan child_swaitForInit20 = [0] of {int};
	run swaitForInit2(_ch0,child_swaitForInit20);
	child_swaitForInit20?0;
	_ch1.in!0;
	_ch1.sending?state;
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
