#define lb_for291_0  -1
#define ub_for291_1  -1

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
		for(i : lb_for291_0.. ub_for291_1) {
for10:		chan child_dtryDial40 = [0] of {int};
		run dtryDial4(child_dtryDial40);
		child_dtryDial40?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
for10_exit:	goto stop_process
stop_process:}

proctype dtryDial4(chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: concurrencyCh.in!0 -> 
			break
		:: true -> 
			do
			:: concurrencyCh.in!0 -> 
				break
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		od
	:: true;
	fi;
	run Anonymous1(concurrencyCh,chv,concurrencyCh);
	do
	:: true -> 
		break
	:: true -> 
		break
	od;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef concurrencyCh;Chandef chv;Chandef concurrencyCh) {
	bool closed; 
	int i;
	ch.in!0;
	
	if
	:: true -> 
		concurrencyCh.in?0
	:: true;
	fi;
stop_process:
}
