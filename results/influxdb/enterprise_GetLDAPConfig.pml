
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_mrequestLDAPChannel20 = [0] of {int};
	chan _ch0_in = [1] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run mrequestLDAPChannel2(_ch0,child_mrequestLDAPChannel20);
	child_mrequestLDAPChannel20?0;
	do
	:: true -> 
		
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
		goto stop_process
	:: _ch0.in?0 -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od
stop_process:}

proctype mrequestLDAPChannel2(Chandef errors;chan child) {
	bool closed; 
	int i;
	Chandef _ch1;
	chan _ch1_in = [1] of {int};
	_ch1.in = _ch1_in;
	goto stop_process;
	child!0;
stop_process:
}
