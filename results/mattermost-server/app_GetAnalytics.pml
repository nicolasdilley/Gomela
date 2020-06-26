
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		Chandef _ch7;
		chan _ch7_in = [1] of {int};
		Chandef _ch6;
		chan _ch6_in = [1] of {int};
		Chandef _ch5;
		chan _ch5_in = [1] of {int};
		Chandef _ch1;
		chan _ch1_in = [1] of {int};
		Chandef _ch0;
		chan _ch0_in = [1] of {int};
		_ch0.in = _ch0_in;
		run chanMonitor(_ch0);
		_ch1.in = _ch1_in;
		run chanMonitor(_ch1);
		run Anonymous0(_ch0,_ch1,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
		run Anonymous1(_ch0,_ch1,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
		
		if
		:: true -> 
			Chandef _ch2;
			chan _ch2_in = [1] of {int};
			_ch2.in = _ch2_in;
			run chanMonitor(_ch2);
			run Anonymous2(_ch0,_ch1,_ch2,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan)
		:: true -> 
			Chandef _ch3;
			chan _ch3_in = [1] of {int};
			_ch3.in = _ch3_in;
			run chanMonitor(_ch3);
			run Anonymous3(_ch0,_ch1,_ch2,_ch3,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan)
		fi;
		
		if
		:: true -> 
			Chandef _ch4;
			chan _ch4_in = [1] of {int};
			_ch4.in = _ch4_in;
			run chanMonitor(_ch4);
			run Anonymous4(_ch0,_ch1,_ch2,_ch3,_ch4,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan)
		:: true;
		fi;
		_ch5.in = _ch5_in;
		run chanMonitor(_ch5);
		run Anonymous5(_ch0,_ch1,_ch2,_ch3,_ch4,_ch5,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
		_ch6.in = _ch6_in;
		run chanMonitor(_ch6);
		run Anonymous6(_ch0,_ch1,_ch2,_ch3,_ch4,_ch5,_ch6,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
		_ch7.in = _ch7_in;
		run chanMonitor(_ch7);
		run Anonymous7(_ch0,_ch1,_ch2,_ch3,_ch4,_ch5,_ch6,_ch7,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
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
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi;
		_ch5.in?0;
		
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
			do
			:: true -> 
for10:
			od
		fi;
		_ch6.in?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		_ch7.in?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					goto stop_process
				:: true -> 
					
					if
					:: true -> 
						Chandef _ch11;
						chan _ch11_in = [1] of {int};
						Chandef _ch10;
						chan _ch10_in = [1] of {int};
						Chandef _ch9;
						chan _ch9_in = [1] of {int};
						Chandef _ch8;
						chan _ch8_in = [1] of {int};
						_ch8.in = _ch8_in;
						run chanMonitor(_ch8);
						run Anonymous8(_ch0,_ch1,_ch2,_ch3,_ch4,_ch5,_ch6,_ch7,_ch8,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
						_ch9.in = _ch9_in;
						run chanMonitor(_ch9);
						run Anonymous9(_ch0,_ch1,_ch2,_ch3,_ch4,_ch5,_ch6,_ch7,_ch8,_ch9,commandChan,sessionChan,fileChan,hashtagChan);
						_ch10.in = _ch10_in;
						run chanMonitor(_ch10);
						run Anonymous10(_ch0,_ch1,_ch2,_ch3,_ch4,_ch5,_ch6,_ch7,_ch8,_ch9,_ch10,sessionChan,fileChan,hashtagChan);
						_ch11.in = _ch11_in;
						run chanMonitor(_ch11);
						run Anonymous11(_ch0,_ch1,_ch2,_ch3,_ch4,_ch5,_ch6,_ch7,_ch8,_ch9,_ch10,_ch11,fileChan,hashtagChan);
						
						if
						:: true -> 
							Chandef _ch13;
							chan _ch13_in = [1] of {int};
							Chandef _ch12;
							chan _ch12_in = [1] of {int};
							_ch12.in = _ch12_in;
							run chanMonitor(_ch12);
							run Anonymous12(_ch0,_ch1,_ch2,_ch3,_ch4,_ch5,_ch6,_ch7,_ch8,_ch9,_ch10,_ch11,_ch12,hashtagChan);
							_ch13.in = _ch13_in;
							run chanMonitor(_ch13);
							run Anonymous13(_ch0,_ch1,_ch2,_ch3,_ch4,_ch5,_ch6,_ch7,_ch8,_ch9,_ch10,_ch11,_ch12,_ch13)
						:: true;
						fi;
						
						if
						:: true -> 
							
							if
							:: true -> 
								goto stop_process
							:: true;
							fi
						fi;
						
						if
						:: true -> 
							
							if
							:: true -> 
								goto stop_process
							:: true;
							fi
						fi;
						_ch8.in?0;
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						_ch9.in?0;
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						_ch10.in?0;
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						_ch11.in?0;
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						goto stop_process
					:: true;
					fi
				fi
			fi
		fi
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	_ch0.in!0;
	_ch0.sending?state;
	_ch0.closing!true;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	_ch1.in!0;
	_ch1.sending?state;
	_ch1.closing!true;
stop_process:
}
proctype Anonymous2(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	_ch2.in!0;
	_ch2.sending?state;
	_ch2.closing!true;
stop_process:
}
proctype Anonymous3(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	_ch3.in!0;
	_ch3.sending?state;
	_ch3.closing!true;
stop_process:
}
proctype Anonymous4(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef _ch4;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	_ch4.in!0;
	_ch4.sending?state;
	_ch4.closing!true;
stop_process:
}
proctype Anonymous5(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef _ch4;Chandef _ch5;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	_ch5.in!0;
	_ch5.sending?state;
	_ch5.closing!true;
stop_process:
}
proctype Anonymous6(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef _ch4;Chandef _ch5;Chandef _ch6;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	_ch6.in!0;
	_ch6.sending?state;
	_ch6.closing!true;
stop_process:
}
proctype Anonymous7(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef _ch4;Chandef _ch5;Chandef _ch6;Chandef _ch7;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	_ch7.in!0;
	_ch7.sending?state;
	_ch7.closing!true;
stop_process:
}
proctype Anonymous8(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef _ch4;Chandef _ch5;Chandef _ch6;Chandef _ch7;Chandef _ch8;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	_ch8.in!0;
	_ch8.sending?state;
	_ch8.closing!true;
stop_process:
}
proctype Anonymous9(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef _ch4;Chandef _ch5;Chandef _ch6;Chandef _ch7;Chandef _ch8;Chandef _ch9;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	_ch9.in!0;
	_ch9.sending?state;
	_ch9.closing!true;
stop_process:
}
proctype Anonymous10(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef _ch4;Chandef _ch5;Chandef _ch6;Chandef _ch7;Chandef _ch8;Chandef _ch9;Chandef _ch10;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	_ch10.in!0;
	_ch10.sending?state;
	_ch10.closing!true;
stop_process:
}
proctype Anonymous11(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef _ch4;Chandef _ch5;Chandef _ch6;Chandef _ch7;Chandef _ch8;Chandef _ch9;Chandef _ch10;Chandef _ch11;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	_ch11.in!0;
	_ch11.sending?state;
	_ch11.closing!true;
stop_process:
}
proctype Anonymous12(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef _ch4;Chandef _ch5;Chandef _ch6;Chandef _ch7;Chandef _ch8;Chandef _ch9;Chandef _ch10;Chandef _ch11;Chandef _ch12;Chandef hashtagChan) {
	bool closed; 
	int i;
	_ch12.in!0;
	_ch12.sending?state;
	_ch12.closing!true;
stop_process:
}
proctype Anonymous13(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3;Chandef _ch4;Chandef _ch5;Chandef _ch6;Chandef _ch7;Chandef _ch8;Chandef _ch9;Chandef _ch10;Chandef _ch11;Chandef _ch12;Chandef _ch13) {
	bool closed; 
	int i;
	_ch13.in!0;
	_ch13.sending?state;
	_ch13.closing!true;
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
