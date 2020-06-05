#define lb_for33_0  -1
#define ub_for33_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for33_0 != -1 && ub_for33_1 != -1 -> 
				for(i : lb_for33_0.. ub_for33_1) {
for10:			do
			:: true -> 
				break
			:: true -> 
				
				if
				:: true -> 
					c_send.closing!true
				:: true;
				fi;
				break
			:: true -> 
				do
				:: true -> 
for11:					do
					:: true -> 
						break
					:: true -> 
						c_send.closing!true;
						break
					od
				od;
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				break
			:: true -> 
				
				if
				:: true -> 
					c_send.closing!true
				:: true;
				fi;
				break
			:: true -> 
				do
				:: true -> 
for11:					do
					:: true -> 
						break
					:: true -> 
						c_send.closing!true;
						break
					od
				od;
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
