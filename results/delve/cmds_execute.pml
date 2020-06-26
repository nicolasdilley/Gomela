#define lb_for636_0  -1
#define ub_for636_1  -1

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
	fi;
	_ch0.in = _ch0_in;
	

	if
	:: true;
	:: true -> 
		goto stop_process
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		chan child_cmdswaitForDisconnectSignal10 = [0] of {int};
		run cmdswaitForDisconnectSignal1(_ch0,child_cmdswaitForDisconnectSignal10);
		child_cmdswaitForDisconnectSignal10?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype cmdswaitForDisconnectSignal1(Chandef disconnectChan;chan child) {
	bool closed; 
	int i;
	Chandef _ch1;
	chan _ch1_in = [1] of {int};
	_ch1.in = _ch1_in;
	
	if
	:: true -> 
		run Anonymous1(disconnectChan,_ch1,disconnectChan);
		do
		:: disconnectChan.in?0 -> 
			break
		od
	:: true -> 
		do
		:: _ch1.in?0 -> 
			break
		:: disconnectChan.in?0 -> 
			break
		od
	fi;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef disconnectChan;Chandef _ch1;Chandef disconnectChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: _ch1.in?0 -> 
			break
		od
	od;
for10_exit:stop_process:
}
