#define lb_for671_0  -1
#define ub_for671_1  -1
#define lb_for679_2  -1
#define ub_for679_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	run Anonymous0(_ch0,_ch1);
outer:		do
	:: true -> 
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: true -> 
			break
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: true -> 
			break
		:: _ch0.in?0 -> 
			_ch1.in!0;
			_ch1.sending?state;
			
			if
			:: true -> 
				

				if
				:: true -> 
					
					if
					:: true -> 
						goto outer
					fi
				:: true;
				:: true;
				:: true;
				:: true;
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				fi
			:: true;
			fi;
			break
		od
	od;
for20_exit:;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		_ch0.in!0;
		_ch1.in?0
	od;
for10_exit:stop_process:
}
