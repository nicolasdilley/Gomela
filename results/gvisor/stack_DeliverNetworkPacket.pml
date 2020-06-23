#define lb_for61_0  -1
#define ub_for61_1  -1

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
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:
	od;
	
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
			
			if
			:: true -> 
				chan child_n_stack_forwarderenqueue50 = [0] of {int};
				run n_stack_forwarderenqueue5(child_n_stack_forwarderenqueue50);
				child_n_stack_forwarderenqueue50?0;
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi
stop_process:}

proctype n_stack_forwarderenqueue5(chan child) {
	bool closed; 
	int i;
	
	if
	:: lb_for61_0 != -1 && ub_for61_1 != -1 -> 
				for(i : lb_for61_0.. ub_for61_1) {
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
for20_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous1(ch,ch);
	child!0;
stop_process:
}
proctype Anonymous1(Chandef ch;Chandef ch) {
	bool closed; 
	int i;
	do
	:: ch.in?0 -> 
		break
	:: true -> 
		break
	od;
	do
	:: true -> 
for30:
	od;
stop_process:
}
