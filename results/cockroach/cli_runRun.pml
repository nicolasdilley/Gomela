#define lb_for329_0  -1
#define ub_for329_1  -1
#define lb_for354_2  -1
#define ub_for354_3  -1
#define lb_for221_4  -1
#define ub_for221_5  -1
#define lb_for439_6  -1
#define ub_for439_7  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch2_in = [3] of {int};
	int i;
	Chandef _ch2;
	Chandef _ch0;
	

	if
	:: true;
	:: true;
	:: true -> 
		goto stop_process
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		od;
for10_exit:
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
			goto stop_process
		:: true;
		fi
	od;
for20_exit:	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	
	if
	:: true -> 
		Chandef _ch1;
		chan _ch1_in = [0] of {int};
		_ch1.in = _ch1_in;
		run chanMonitor(_ch1)
	:: true;
	fi;
	run Anonymous0(_ch0,_ch1,done);
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
	run Anonymous3(_ch0,_ch1,_ch2);
	
	if
	:: true -> 
		run Anonymous4(_ch0,_ch1,_ch2)
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
	do
	:: true -> 
for40:		do
		:: _ch0.in?0 -> 
			goto stop_process
		:: true -> 
			break
		:: true -> 
			break
		:: _ch2.in?0 -> 
			goto stop_process
		od
	od;
for40_exit:
stop_process:}

proctype cliworkerRun5(Chandef errCh;chan child) {
	bool closed; 
	int i;
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
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			errCh.in!0;
			errCh.sending?state
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for31_exit:	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef done) {
	bool closed; 
	int i;
	chan child_cliworkerRun51 = [0] of {int};
	
	if
	:: true -> 
		chan child_cliworkerRun50 = [0] of {int};
		run cliworkerRun5(_ch0,child_cliworkerRun50);
		child_cliworkerRun50?0
	:: true;
	fi;
	run cliworkerRun5(_ch0,child_cliworkerRun51);
	child_cliworkerRun51?0;
stop_process:
}
proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef done) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		run Anonymous0(_ch0,_ch1,done)
	od;
	
	if
	:: true -> 
		rampDone.closing!true
	:: true;
	fi;
stop_process:
}
proctype Anonymous3(Chandef _ch0;Chandef _ch1;Chandef _ch2) {
	bool closed; 
	int i;
	_ch2.in!0;
	_ch2.sending?state;
stop_process:
}
proctype Anonymous4(Chandef _ch0;Chandef _ch1;Chandef _ch2) {
	bool closed; 
	int i;
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
