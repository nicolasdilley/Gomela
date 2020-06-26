#define lb_for1153_0  -1
#define ub_for1153_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch2_in = [0] of {int};
	bool state = false;
	chan child_mwatchForNewContainers10 = [0] of {int};
	chan _ch3_in = [0] of {int};
	chan _ch0_in = [0] of {int};
	int i;
	Chandef _ch3;
	Chandef _ch2;
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
	_ch0.in = _ch0_in;
	run mwatchForNewContainers1(_ch0,child_mwatchForNewContainers10);
	child_mwatchForNewContainers10?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch2.in = _ch2_in;
	_ch3.in = _ch3_in;
	goto stop_process
stop_process:}

proctype mwatchForNewContainers1(Chandef quit;chan child) {
	bool closed; 
	int i;
		for(i : 1.. m.containerWatchers) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous1(quit,quit);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef quit;Chandef quit) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: true;
				fi
			:: true;
			fi;
			break
		:: quit.in?0 -> 
			do
			:: true -> 
for21:
			od;
			
			if
			:: true -> 
				quit.in!0
			:: true -> 
				quit.in!0;
				goto stop_process
			fi;
			break
		od
	od;
for20_exit:stop_process:
}
