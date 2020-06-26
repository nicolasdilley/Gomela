
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous0(_ch0);
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0
		fi
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
	fi
stop_process:}

proctype importcclrunImport4(Chandef progCh;chan child) {
	bool closed; 
	int i;
	chan child_importcclmakeInputConverter47 = [0] of {int};
	Chandef _ch1;
	chan _ch1_in = [10] of {int};
	_ch1.in = _ch1_in;
	chan child_importcclmakeInputConverter47 = [0] of {int};
	run importcclmakeInputConverter4(_ch1,child_importcclmakeInputConverter47);
	child_importcclmakeInputConverter47?0;
	
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
	goto stop_process;
	child!0;
stop_process:
}
proctype importcclmakeInputConverter4(Chandef kvCh;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for10:			do
			:: true -> 
for11:
			od
		od
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		do
		:: true -> 
for20:			
			if
			:: true -> 
				break
			:: true;
			fi
		od;
		
		if
		:: true -> 
			chan child_importcclnewWorkloadReader30 = [0] of {int};
			run importcclnewWorkloadReader3(child_importcclnewWorkloadReader30);
			child_importcclnewWorkloadReader30?0;
			goto stop_process
		:: true;
		fi;
		chan child_importcclnewCSVInputReader71 = [0] of {int};
		run importcclnewCSVInputReader7(child_importcclnewCSVInputReader71);
		child_importcclnewCSVInputReader71?0;
		goto stop_process
	:: true -> 
		chan child_importcclnewMysqloutfileReader62 = [0] of {int};
		run importcclnewMysqloutfileReader6(child_importcclnewMysqloutfileReader62);
		child_importcclnewMysqloutfileReader62?0;
		goto stop_process
	:: true -> 
		chan child_importcclnewMysqldumpReader43 = [0] of {int};
		run importcclnewMysqldumpReader4(child_importcclnewMysqldumpReader43);
		child_importcclnewMysqldumpReader43?0;
		goto stop_process
	:: true -> 
		chan child_importcclnewPgCopyReader64 = [0] of {int};
		run importcclnewPgCopyReader6(child_importcclnewPgCopyReader64);
		child_importcclnewPgCopyReader64?0;
		goto stop_process
	:: true -> 
		chan child_importcclnewPgDumpReader55 = [0] of {int};
		run importcclnewPgDumpReader5(child_importcclnewPgDumpReader55);
		child_importcclnewPgDumpReader55?0;
		goto stop_process
	:: true -> 
		chan child_importcclnewAvroInputReader66 = [0] of {int};
		run importcclnewAvroInputReader6(child_importcclnewAvroInputReader66);
		child_importcclnewAvroInputReader66?0;
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	child!0;
stop_process:
}
proctype importcclnewWorkloadReader3(chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
proctype importcclnewCSVInputReader7(chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
proctype importcclnewMysqloutfileReader6(chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
proctype importcclnewMysqldumpReader4(chan child) {
	bool closed; 
	int i;
		for(i : 1.. tables) {
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	goto stop_process;
	child!0;
stop_process:
}
proctype importcclnewPgCopyReader6(chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
proctype importcclnewPgDumpReader5(chan child) {
	bool closed; 
	int i;
		for(i : 1.. descs) {
for40:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	};
	goto stop_process;
	child!0;
stop_process:
}
proctype importcclnewAvroInputReader6(chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	chan child_importcclrunImport48 = [0] of {int};
	run importcclrunImport4(_ch0,child_importcclrunImport48);
	child_importcclrunImport48?0;
	_ch0.closing!true;
stop_process:
}
proctype chanMonitor(Chandef ch) {
	bool closed; 
	int i;
	state = false;
	do
	:: true -> 
		if
		:: state -> 
end:			if
			:: ch.sending!state -> 
				assert(false)
			:: ch.closing?true -> 
				assert(false)
			:: ch.in!0;
			:: ch.is_closed!state;
			fi
		:: else -> 
end1:			if
			:: ch.sending!state;
			:: ch.closing?true -> 
				state = true
			:: ch.is_closed!state;
			fi
		fi
	od;
stop_process:
}
