#define lb_for141_0  -1
#define ub_for141_1  -1

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
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0(_ch0,_ch1);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
loop:		do
	:: true -> 
for10:		do
		:: _ch1.in?0 -> 
			
			if
			:: true -> 
				goto loop
			:: true;
			fi;
			

			if
			:: true -> 
				jobStatus.in!0;
				jobStatus.sending?state;
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					jobStatus.in!0;
					jobStatus.sending?state;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					jobStatus.in!0;
					jobStatus.sending?state;
					goto stop_process
				:: true;
				fi;
				jobStatus.in!0;
				jobStatus.sending?state;
				goto stop_process
			:: true;
			fi;
			break
		:: true -> 
			_ch0.in!0;
			_ch0.sending?state;
			goto stop_process
		od
	od;
for10_exit:;
	_ch0.in!0;
stop_process:
}
