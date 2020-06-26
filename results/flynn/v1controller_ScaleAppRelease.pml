#define lb_for344_0  -1
#define ub_for344_1  -1

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
		Chandef _ch0;
		chan _ch0_in = [0] of {int};
		_ch0.in = _ch0_in;
		chan child_cStreamEvents20 = [0] of {int};
		run cStreamEvents2(_ch0,child_cStreamEvents20);
		child_cStreamEvents20?0;
		
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
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for20:		do
		:: true -> 
			
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
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			fi;
			break
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:
stop_process:}

proctype cStreamEvents2(Chandef output;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		do
		:: true -> 
for10:
		od
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
