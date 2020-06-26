#define lb_for69_0  -1
#define ub_for69_1  -1

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
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
		for(i : 1.. scw.destinationShards) {
for20:		run Anonymous0(insertChannels)
	};
	
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
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
		for(i : 1.. scw.sourceShards) {
for30:				for(i : 1.. sourceSchemaDefinition.TableDefinitions) {
for31:			
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
					goto stop_process
				:: true;
				fi
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
						for(i : 1.. chunks) {
for32:				run Anonymous3(insertChannels)
			}
		}
	};
		for(i : 1.. scw.destinationShards) {
for40:		.closing!true
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for50:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
		for(i : 1.. scw.destinationShards) {
for60:		run Anonymous4(insertChannels)
	};
	goto stop_process
stop_process:}

proctype executorfetchLoop2(chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for22:		do
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
			break
		:: true -> 
			goto stop_process
		od
	od;
for22_exit:	child!0;
stop_process:
}
proctype Anonymous0(Chandef ) {
	bool closed; 
	int i;
	chan child_executorfetchLoop20 = [0] of {int};
	run executorfetchLoop2(child_executorfetchLoop20);
	child_executorfetchLoop20?0;
stop_process:
}
proctype Anonymous0(Chandef ) {
	bool closed; 
	int i;
		for(i : 0.. scw.destinationWriterCount-1) {
for21:		run Anonymous0(insertChannels)
	};
for21_exit:stop_process:
}
proctype Anonymous3(Chandef ) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for33:
	od;
stop_process:
}
proctype Anonymous4(Chandef ) {
	bool closed; 
	int i;
	do
	:: true -> 
for61:		
		if
		:: true -> 
			break
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
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
