
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example375738237/server/accounts.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int old_signingKeys = -2;
	int ac_Revocations = -2;
	int gatherClients295221 = -2;
	bool state = false;
	int allJsExports = -2;
	int clients = -2;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: 0 != -2 && old_signingKeys-1 != -3 -> 
						for(i : 0.. old_signingKeys-1) {
for20:				
				if
				:: true -> 
					break
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for20:				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for20_exit:
	:: true -> 
		
		if
		:: 0 != -2 && old_signingKeys-1 != -3 -> 
						for(i : 0.. old_signingKeys-1) {
for20:				
				if
				:: true -> 
					break
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for20:				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for20_exit:
	fi;
	
	if
	:: true -> 
				for(i : 0.. allJsExports-1) {
for30:
		}
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. gatherClients295221-1) {
for60:
		}
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. clients-1) {
for70:
		}
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. ac_Revocations-1) {
for100:
		}
	fi;
	
	if
	:: true -> 
		Wgdef a_srv_grWG;
		run wgMonitor(a_srv_grWG)
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. clients-1) {
for130:
		}
	:: true;
	fi
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
}
