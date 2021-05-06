
// https://github.com/goharbor/harbor/blob/master/src/pkg/ldap/ldap_test.go#L59
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSearchUser590 = [1] of {int};
	run TestSearchUser59(child_TestSearchUser590)
stop_process:skip
}

proctype TestSearchUser59(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close3052 = [1] of {int};
	chan child_SearchUser1394 = [1] of {int};
	chan child_SearchUser1393 = [1] of {int};
	chan child_Bind1871 = [1] of {int};
	chan child_Open1920 = [1] of {int};
	Mutexdef session_ldapConn_messageMutex;
	Wgdef session_ldapConn_wgClose;
	run wgMonitor(session_ldapConn_wgClose);
	run mutexMonitor(session_ldapConn_messageMutex);
	run Open192(session_ldapConn_wgClose,session_ldapConn_messageMutex,child_Open1920);
	child_Open1920?0;
	run Bind187(session_ldapConn_wgClose,session_ldapConn_messageMutex,child_Bind1871);
	child_Bind1871?0;
	run SearchUser139(session_ldapConn_wgClose,session_ldapConn_messageMutex,child_SearchUser1393);
	child_SearchUser1393?0;
	run SearchUser139(session_ldapConn_wgClose,session_ldapConn_messageMutex,child_SearchUser1394);
	child_SearchUser1394?0;
	stop_process: skip;
		run Close305(session_ldapConn_wgClose,session_ldapConn_messageMutex,child_Close3052);
	child_Close3052?0;
	child!0
}
proctype Open192(Wgdef s_ldapConn_wgClose;Mutexdef s_ldapConn_messageMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ldap_messageMutex;
	Wgdef ldap_wgClose;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run wgMonitor(ldap_wgClose);
		run mutexMonitor(ldap_messageMutex);
		

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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Bind187(Wgdef s_ldapConn_wgClose;Mutexdef s_ldapConn_messageMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Bind1871 = [1] of {int};
	run Bind187(s_ldapConn_wgClose,s_ldapConn_messageMutex,child_Bind1871);
	child_Bind1871?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Close305(Wgdef s_ldapConn_wgClose;Mutexdef s_ldapConn_messageMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close3052 = [1] of {int};
	

	if
	:: true -> 
		run Close305(s_ldapConn_wgClose,s_ldapConn_messageMutex,child_Close3052);
		child_Close3052?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype SearchUser139(Wgdef s_ldapConn_wgClose;Mutexdef s_ldapConn_messageMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SearchLdap2253 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run SearchLdap225(s_ldapConn_wgClose,s_ldapConn_messageMutex,child_SearchLdap2253);
	child_SearchLdap2253?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SearchLdap225(Wgdef s_ldapConn_wgClose;Mutexdef s_ldapConn_messageMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SearchLdapAttribute2423 = [1] of {int};
	run SearchLdapAttribute242(s_ldapConn_wgClose,s_ldapConn_messageMutex,child_SearchLdapAttribute2423);
	child_SearchLdapAttribute2423?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SearchLdapAttribute242(Wgdef s_ldapConn_wgClose;Mutexdef s_ldapConn_messageMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Bind1873 = [1] of {int};
	run Bind187(s_ldapConn_wgClose,s_ldapConn_messageMutex,child_Bind1873);
	child_Bind1873?0;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

