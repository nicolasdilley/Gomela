
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example476275474/go/mysql/ldapauthserver/auth_server_ldap.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef lci_Conn_wgSender;
	Wgdef conn_wgSender;
	int i;
	Wgdef conn_wgClose;
	Wgdef lci_Conn_wgClose;
	bool state = false;
	run wgMonitor(conn_wgSender);
	run wgMonitor(conn_wgClose);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(lci_Conn_wgSender);
	run wgMonitor(lci_Conn_wgClose);
	
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
