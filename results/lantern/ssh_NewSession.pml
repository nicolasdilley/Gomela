
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan child_sshnewSession21 = [0] of {int};
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sshnewSession2(child_sshnewSession21);
	child_sshnewSession21?0;
	goto stop_process
stop_process:}

proctype sshnewSession2(chan child) {
	bool closed; 
	int i;
	Chandef _ch0;
	chan _ch0_in = [1] of {int};
	_ch0.in = _ch0_in;
	run Anonymous1(reqs,_ch0,reqs);
	goto stop_process;
	child!0;
stop_process:
}
proctype swait1(Chandef reqs;chan child) {
	bool closed; 
	int i;
	do
	:: reqs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			reqs.in?0;
			

			if
			:: true;
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi
		fi
	od;
	
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
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef reqs;Chandef _ch0;Chandef reqs) {
	bool closed; 
	int i;
	chan child_swait10 = [0] of {int};
	run swait1(reqs,child_swait10);
	child_swait10?0;
	_ch0.in!0;
stop_process:
}
