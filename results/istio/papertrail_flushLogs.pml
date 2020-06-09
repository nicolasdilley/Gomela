#define lb_for168_0  -1
#define ub_for168_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for168_0 != -1 && ub_for168_1 != -1 -> 
				for(i : lb_for168_0.. ub_for168_1) {
for10:			do
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: 0 != -1 && p.maxWorkers-1 != -1 -> 
										for(i : 0.. p.maxWorkers-1) {
for11:
					}
				:: else -> 
					do
					:: true -> 
for11:
					:: true -> 
						break
					od
				fi;
for11_exit:				hose.closing!true;
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: 0 != -1 && p.maxWorkers-1 != -1 -> 
										for(i : 0.. p.maxWorkers-1) {
for11:
					}
				:: else -> 
					do
					:: true -> 
for11:
					:: true -> 
						break
					od
				fi;
for11_exit:				hose.closing!true;
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

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
