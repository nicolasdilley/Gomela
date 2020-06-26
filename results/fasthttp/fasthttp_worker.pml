#define lb_for2503_0  -1
#define ub_for2503_1  -1
#define lb_for2596_2  -1
#define ub_for2596_3  -1
#define lb_for2451_4  -1
#define ub_for2451_5  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch3_in = [0] of {int};
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch4_in = [0] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch4;
	Chandef _ch3;
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
	run Anonymous0(_ch0,_ch1,stopR,doneR);
	_ch3.in = _ch3_in;
	run chanMonitor(_ch3);
	_ch4.in = _ch4_in;
	run chanMonitor(_ch4);
	run Anonymous2(_ch0,_ch1,_ch3,_ch4);
	do
	:: _ch1.in?0 -> 
		_ch3.closing!true;
		_ch4.in?0;
		break
	:: _ch4.in?0 -> 
		_ch0.closing!true;
		_ch1.in?0;
		break
	od;
	
	if
	:: lb_for2451_4 != -1 && ub_for2451_5 != -1 -> 
				for(i : lb_for2451_4.. ub_for2451_5) {
for30:			w_done.in!0;
			w_done.sending?state
		}
	:: else -> 
		do
		:: true -> 
for30:			w_done.in!0;
			w_done.sending?state
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

proctype cwriter2(Chandef stopCh;chan child) {
	bool closed; 
	int i;
	Chandef _ch2;
	chan _ch2_in = [0] of {int};
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
	_ch2.closing!true;
	do
	:: true -> 
for10:againChW:				do
		:: true -> 
			break
		:: true -> 
			do
			:: true -> 
				break
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto againChW;
				break
			od;
			break
		od;
		
		if
		:: true -> 
			w_done.in!0;
			w_done.sending?state
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				w_done.in!0;
				w_done.sending?state;
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			w_done.in!0;
			w_done.sending?state;
			goto stop_process
		:: true;
		fi;
againChR:				do
		:: chR.in!0 -> 
			chR.sending?state;
			break
		:: true -> 
			do
			:: chR.in!0 -> 
				chR.sending?state;
				break
			:: true -> 
				w_done.in!0;
				w_done.sending?state;
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					w_done.in!0;
					w_done.sending?state;
					goto stop_process
				:: true;
				fi;
				goto againChR;
				break
			od;
			break
		od
	od;
for10_exit:	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef stopR;Chandef doneR) {
	bool closed; 
	int i;
	chan child_cwriter20 = [0] of {int};
	run cwriter2(_ch0,child_cwriter20);
	child_cwriter20?0;
	_ch1.in!0;
	_ch1.sending?state;
stop_process:
}
proctype creader2(Chandef stopCh;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: true -> 
			break
		:: true -> 
			do
			:: true -> 
				break
			:: true -> 
				goto stop_process
			od;
			break
		od;
		
		if
		:: true -> 
			
			if
			:: true -> 
				w_done.in!0;
				w_done.sending?state;
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			w_done.in!0;
			w_done.sending?state;
			goto stop_process
		:: true;
		fi;
		w_done.in!0;
		w_done.sending?state
	od;
for20_exit:	child!0;
stop_process:
}
proctype Anonymous2(Chandef _ch0;Chandef _ch1;Chandef _ch3;Chandef _ch4) {
	bool closed; 
	int i;
	chan child_creader21 = [0] of {int};
	run creader2(_ch3,child_creader21);
	child_creader21?0;
	_ch4.in!0;
	_ch4.sending?state;
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
