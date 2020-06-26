#define lb_for37_0  -1
#define ub_for37_1  -1

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
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	run go_netxdoCopy6(_ch0);
	run go_netxdoCopy6(_ch1);
	_ch0.in?0;
	_ch1.in?0;
	goto stop_process
stop_process:}

proctype go_netxdoCopy6(Chandef errCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
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
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				goto stop_process
			fi
		:: true;
		fi
	od;
for10_exit:	errCh.in!0;
stop_process:
}
