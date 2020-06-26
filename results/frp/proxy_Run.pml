#define lb_for164_0  -1
#define ub_for164_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1024] of {int};
	chan _ch2_in = [0] of {int};
	bool state = false;
	chan _ch1_in = [1024] of {int};
	int i;
	Chandef _ch2;
	Chandef _ch1;
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
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	_ch2.in = _ch2_in;
	run Anonymous0(_ch0,_ch1,_ch2);
	run Anonymous1(_ch0,_ch1,_ch2);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef _ch2) {
	bool closed; 
	int i;
		for(i : lb_for164_0.. ub_for164_1) {
for10:		
		if
		:: true -> 
			do
			:: _ch2.in?0 -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				break
			od
		:: true;
		fi;
		_ch2.in?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
for10_exit:stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1;Chandef _ch2) {
	bool closed; 
	int i;
stop_process:
}
