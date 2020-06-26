#define lb_for165_0  -1
#define ub_for165_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan child_strategydrainCh10 = [0] of {int};
	chan _ch1_in = [0] of {int};
	bool state = false;
	chan _ch0_in = [0] of {int};
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
	run strategydrainCh1(child_strategydrainCh10);
	child_strategydrainCh10?0
stop_process:}

proctype strategydrainCh1(chan child) {
	bool closed; 
	int i;
loop:		do
	:: true -> 
for10:		do
		:: true -> 
			
			if
			:: true -> 
				goto loop
			:: true;
			fi;
			break
		:: true -> 
			goto loop;
			break
		od
	od;
for10_exit:;
	child!0;
stop_process:
}
