
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [1] of {int};
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
	run Anonymous0(_ch0,cmnchan,gchan,fchan,umc);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run Anonymous1(_ch0,_ch1,gchan,fchan,umc);
	
	if
	:: true -> 
		Chandef _ch2;
		chan _ch2_in = [1] of {int};
		_ch2.in = _ch2_in;
		run chanMonitor(_ch2);
		run Anonymous2(_ch0,_ch1,_ch2,fchan,umc)
	:: true;
	fi;
	
	if
	:: true -> 
		Chandef _ch3;
		chan _ch3_in = [1] of {int};
		_ch3.in = _ch3_in;
		run chanMonitor(_ch3);
		run Anonymous3(_ch0,_ch1,_ch2,_ch3,umc)
	:: true;
	fi;
	_ch0.in?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch1.in?0;
	
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
		do
		:: true -> 
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		od;
		
		if
		:: true -> 
			do
			:: true -> 
for20:
			od
		:: true;
		fi;
		run Anonymous4(_ch0,_ch1,_ch2,_ch3,umc);
		do
		:: true -> 
for30:
		od
	fi;
		for(i : 1.. mentions.Mentions) {
for40:		run Anonymous5(_ch0,_ch1,_ch2,_ch3,umc)
	};
	
	if
	:: true -> 
		do
		:: true -> 
for50:
		od
	:: true;
	fi;
	do
	:: true -> 
for60:
	od;
	
	if
	:: true -> 
		do
		:: true -> 
for70:
		od;
		do
		:: true -> 
for80:
		od
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for90:			
			if
			:: true -> 
				break
			:: true;
			fi
		od
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef cmnchan;Chandef gchan;Chandef fchan;Chandef umc) {
	bool closed; 
	int i;
	_ch0.in!0;
	_ch0.sending?state;
	_ch0.closing!true;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1;Chandef gchan;Chandef fchan;Chandef umc) {
	bool closed; 
	int i;
	_ch1.in!0;
	_ch1.sending?state;
	_ch1.closing!true;
stop_process:
}
proctype Anonymous2(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef fchan;Chandef umc) {
	bool closed; 
	int i;
	_ch2.in!0;
	_ch2.sending?state;
	_ch2.closing!true;
stop_process:
}
proctype Anonymous3(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef umc) {
	bool closed; 
	int i;
	_ch3.in!0;
	_ch3.sending?state;
	_ch3.closing!true;
stop_process:
}
proctype Anonymous4(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef umc) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous5(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef umc) {
	bool closed; 
	int i;
	umc.in!0;
	umc.sending?state;
	umc.closing!true;
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
