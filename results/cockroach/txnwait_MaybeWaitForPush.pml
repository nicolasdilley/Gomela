#define lb_for512_0  -1
#define ub_for512_1  -1

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
		goto stop_process
	:: true;
	fi;
	
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
	
	if
	:: true -> 
		Chandef _ch0;
		chan _ch0_in = [1] of {int};
		_ch0.in = _ch0_in;
		chan child_qstartQueryPusherTxn30 = [0] of {int};
		run qstartQueryPusherTxn3(_ch0,child_qstartQueryPusherTxn30);
		child_qstartQueryPusherTxn30?0
	:: true;
	fi;
	do
	:: true -> 
for20:		do
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
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi;
			
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
			break
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi;
			do
			:: true -> 
for21:
			od;
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			readyCh.in!0;
			break
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:
stop_process:}

proctype qstartQueryPusherTxn3(Chandef readyCh;chan child) {
	bool closed; 
	int i;
	chan _ch1_in = [1] of {int};
	Chandef _ch1;
	Chandef _ch2;
	chan _ch1_in = [1] of {int};
	_ch1.in = _ch1_in;
	_ch2.in = _ch2_in;
	
	if
	:: true -> 
		do
		:: true -> 
for10:
		od
	:: true;
	fi;
	
	if
	:: true -> 
		_ch2.in!0
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
