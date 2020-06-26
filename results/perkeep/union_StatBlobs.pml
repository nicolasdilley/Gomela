#define lb_for149_0  -1
#define ub_for149_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [1] of {int};
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
		for(i : 1.. sto.subsets) {
for10:		
		if
		:: true -> 
			run Anonymous0(_ch0,_ch1)
		:: true;
		fi
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous1(_ch0,_ch1);
	do
	:: true -> 
for20:		do
		:: true -> 
			goto stop_process
		:: _ch1.in?0 -> 
			goto stop_process
		:: _ch0.in?0 -> 
			
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
			:: true;
			fi;
			break
		od
	od;
for20_exit:
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		_ch1.in!0
	:: true;
	fi;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
stop_process:
}
