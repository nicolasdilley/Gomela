
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
		

		if
		:: true;
		:: true;
		:: true;
		fi
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous0(_ch0);
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0
		fi
	od
stop_process:}

proctype diffdiffSummary3(Chandef ch;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			

			if
			:: true -> 
				chan child_diffdiffSummaryList30 = [0] of {int};
				run diffdiffSummaryList3(child_diffdiffSummaryList30);
				child_diffdiffSummaryList30?0
			:: true -> 
				chan child_diffdiffSummaryMap33 = [0] of {int};
				run diffdiffSummaryMap3(ch,child_diffdiffSummaryMap33);
				child_diffdiffSummaryMap33?0
			:: true -> 
				chan child_diffdiffSummarySet35 = [0] of {int};
				run diffdiffSummarySet3(ch,child_diffdiffSummarySet35);
				child_diffdiffSummarySet35?0
			:: true -> 
				chan child_diffdiffSummaryStructs37 = [0] of {int};
				run diffdiffSummaryStructs3(ch,child_diffdiffSummaryStructs37);
				child_diffdiffSummaryStructs37?0
			:: true;
			fi
		:: true -> 
			ch.in!0;
			ch.sending?state
		fi
	:: true;
	fi;
	child!0;
stop_process:
}
proctype diffdiffSummaryList3(chan child) {
	bool closed; 
	int i;
	chan _ch1_in = [0] of {int};
	Chandef _ch1;
	Chandef _ch2;
	chan _ch1_in = [0] of {int};
	ch.in!0;
	ch.sending?state;
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
	run Anonymous2(ch,_ch1,_ch2,ch);
	do
	:: _ch1.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch1.in?0;
			
			if
			:: true -> 
				ch.in!0;
				ch.sending?state
			:: true -> 
				ch.in!0;
				ch.sending?state
			fi
		fi
	od;
	child!0;
stop_process:
}
proctype Anonymous2(Chandef ch;Chandef _ch1;Chandef _ch2;Chandef ch) {
	bool closed; 
	int i;
	_ch1.closing!true;
stop_process:
}
proctype diffdiffSummaryMap3(Chandef ch;chan child) {
	bool closed; 
	int i;
	chan child_diffdiffSummaryValueChanged42 = [0] of {int};
	run diffdiffSummaryValueChanged4(ch,child_diffdiffSummaryValueChanged42);
	child_diffdiffSummaryValueChanged42?0;
	child!0;
stop_process:
}
proctype diffdiffSummaryValueChanged4(Chandef ch;chan child) {
	bool closed; 
	int i;
	chan child_diffreportChanges21 = [0] of {int};
	chan _ch4_in = [0] of {int};
	Chandef _ch4;
	Chandef _ch5;
	chan _ch4_in = [0] of {int};
	ch.in!0;
	ch.sending?state;
	_ch4.in = _ch4_in;
	run chanMonitor(_ch4);
	_ch5.in = _ch5_in;
	run chanMonitor(_ch5);
	chan child_diffreportChanges21 = [0] of {int};
	run diffreportChanges2(ch,_ch4,child_diffreportChanges21);
	child_diffreportChanges21?0;
	child!0;
stop_process:
}
proctype Anonymous5(Chandef ch;Chandef _ch4;Chandef _ch5;Chandef ch) {
	bool closed; 
	int i;
	_ch4.closing!true;
stop_process:
}
proctype diffreportChanges2(Chandef ch;Chandef changeChan;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		

		if
		:: true -> 
			ch.in!0;
			ch.sending?state
		:: true -> 
			ch.in!0;
			ch.sending?state
		:: true -> 
			ch.in!0;
			ch.sending?state
		:: true;
		fi
	od;
	child!0;
stop_process:
}
proctype diffdiffSummarySet3(Chandef ch;chan child) {
	bool closed; 
	int i;
	chan child_diffdiffSummaryValueChanged44 = [0] of {int};
	run diffdiffSummaryValueChanged4(ch,child_diffdiffSummaryValueChanged44);
	child_diffdiffSummaryValueChanged44?0;
	child!0;
stop_process:
}
proctype diffdiffSummaryStructs3(Chandef ch;chan child) {
	bool closed; 
	int i;
	chan child_diffdiffSummaryValueChanged46 = [0] of {int};
	run diffdiffSummaryValueChanged4(ch,child_diffdiffSummaryValueChanged46);
	child_diffdiffSummaryValueChanged46?0;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	chan child_diffdiffSummary38 = [0] of {int};
	run diffdiffSummary3(_ch0,child_diffdiffSummary38);
	child_diffdiffSummary38?0;
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
