#define lb_for255_0  -1
#define ub_for255_1  -1
#define lb_for204_2  -1
#define ub_for204_3  -1
#define lb_for218_4  -1
#define ub_for218_5  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [maxConcurrency] of {int};
	bool state = false;
	int i;
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
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
		:: 1 != -1 && maxSurge != -1 -> 
						for(i : 1.. maxSurge) {
for10:				
				if
				:: true -> 
					
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
					fi
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for10:				
				if
				:: true -> 
					
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
					fi
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for10_exit:
	:: true;
	fi;
	_ch0.in = _ch0_in;
	do
	:: true -> 
for20:		run Anonymous0(_ch0);
		_ch0.in?0;
		
		if
		:: true -> 
			chan child_instancegroupswaitForPendingBeforeReturningError30 = [0] of {int};
			run instancegroupswaitForPendingBeforeReturningError3(_ch0,child_instancegroupswaitForPendingBeforeReturningError30);
			child_instancegroupswaitForPendingBeforeReturningError30?0;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			chan child_instancegroupswaitForPendingBeforeReturningError31 = [0] of {int};
			run instancegroupswaitForPendingBeforeReturningError3(_ch0,child_instancegroupswaitForPendingBeforeReturningError31);
			child_instancegroupswaitForPendingBeforeReturningError31?0;
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
sweep:				
		if
		:: lb_for204_2 != -1 && ub_for204_3 != -1 -> 
						for(i : lb_for204_2.. ub_for204_3) {
for22:				do
				:: _ch0.in?0 -> 
					
					if
					:: true -> 
						chan child_instancegroupswaitForPendingBeforeReturningError32 = [0] of {int};
						run instancegroupswaitForPendingBeforeReturningError3(_ch0,child_instancegroupswaitForPendingBeforeReturningError32);
						child_instancegroupswaitForPendingBeforeReturningError32?0;
						goto stop_process
					:: true;
					fi;
					break
				:: true -> 
					goto sweep;
					break
				od
			}
		:: else -> 
			do
			:: true -> 
for22:				do
				:: _ch0.in?0 -> 
					
					if
					:: true -> 
						chan child_instancegroupswaitForPendingBeforeReturningError32 = [0] of {int};
						run instancegroupswaitForPendingBeforeReturningError3(_ch0,child_instancegroupswaitForPendingBeforeReturningError32);
						child_instancegroupswaitForPendingBeforeReturningError32?0;
						goto stop_process
					:: true;
					fi;
					break
				:: true -> 
					goto sweep;
					break
				od
			:: true -> 
				break
			od
		fi;
for22_exit:
	od;
	
	if
	:: true -> 
		
		if
		:: lb_for218_4 != -1 && ub_for218_5 != -1 -> 
						for(i : lb_for218_4.. ub_for218_5) {
for30:				_ch0.in?0;
				
				if
				:: true -> 
					chan child_instancegroupswaitForPendingBeforeReturningError33 = [0] of {int};
					run instancegroupswaitForPendingBeforeReturningError3(_ch0,child_instancegroupswaitForPendingBeforeReturningError33);
					child_instancegroupswaitForPendingBeforeReturningError33?0;
					goto stop_process
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for30:				_ch0.in?0;
				
				if
				:: true -> 
					chan child_instancegroupswaitForPendingBeforeReturningError33 = [0] of {int};
					run instancegroupswaitForPendingBeforeReturningError3(_ch0,child_instancegroupswaitForPendingBeforeReturningError33);
					child_instancegroupswaitForPendingBeforeReturningError33?0;
					goto stop_process
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for30_exit:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in!0;
stop_process:
}
proctype instancegroupswaitForPendingBeforeReturningError3(Chandef terminateChan;chan child) {
	bool closed; 
	int i;
	
	if
	:: lb_for255_0 != -1 && ub_for255_1 != -1 -> 
				for(i : lb_for255_0.. ub_for255_1) {
for21:
		}
	:: else -> 
		do
		:: true -> 
for21:
		:: true -> 
			break
		od
	fi;
for21_exit:	goto stop_process;
	child!0;
stop_process:
}
