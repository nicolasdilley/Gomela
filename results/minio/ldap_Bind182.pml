
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example268613986/cmd/config/identity/ldap/config.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int l_UsernameSearchBaseDNS = -2;
	int i;
	int bindDNS = -2;
	Wgdef conn_wgClose;
	int l_GroupSearchBaseDNS = -2;
	int filters = -2;
	bool state = false;
	run wgMonitor(conn_wgClose);
	
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
				for(i : 0.. l_UsernameSearchBaseDNS-1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. l_GroupSearchBaseDNS-1) {
for20:			
			if
			:: true -> 
								for(i : 0.. bindDNS-1) {
for21:
				}
			:: true -> 
								for(i : 0.. bindDNS-1) {
for21:
				}
			fi;
						for(i : 0.. filters-1) {
for22:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			}
		}
	:: true;
	fi;
	goto stop_process
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
