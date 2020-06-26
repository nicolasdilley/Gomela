#define lb_for485_0  -1
#define ub_for485_1  -1
#define lb_for511_2  -1
#define ub_for511_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1] of {int};
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
	do
	:: true -> 
for10:		do
		:: true -> 
for11:			
			if
			:: true -> 
				break
			:: true;
			fi
		od
	od;
	_ch0.in = _ch0_in;
	run Anonymous0(_ch0);
	run Anonymous1(_ch0);
	do
	:: _ch0.in?0 -> 
		break
	:: true -> 
		break
	od
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	
	if
	:: lb_for485_0 != -1 && ub_for485_1 != -1 -> 
				for(i : lb_for485_0.. ub_for485_1) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:stop_process:
}
proctype Anonymous1(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		
		if
		:: true -> 
			
			if
			:: true -> 
				_ch0.in!0;
				break
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: lb_for511_2 != -1 && ub_for511_3 != -1 -> 
						for(i : lb_for511_2.. ub_for511_3) {
for31:				
				if
				:: true -> 
					_ch0.in!0;
					break
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for31:				
				if
				:: true -> 
					_ch0.in!0;
					break
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for31_exit:
	od;
stop_process:
}
