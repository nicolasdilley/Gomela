
// https://github.com/goharbor/harbor/blob/master/src/pkg/ldap/manager_test.go#L41
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
	chan child_TestSearchUser410 = [1] of {int};
	run TestSearchUser41(child_TestSearchUser410)
stop_process:skip
}

proctype TestSearchUser41(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SearchUser400 = [1] of {int};
	Mutexdef sess_ldapConn_messageMutex;
	Wgdef sess_ldapConn_wgClose;
	run wgMonitor(sess_ldapConn_wgClose);
	run mutexMonitor(sess_ldapConn_messageMutex);
	run SearchUser40(sess_ldapConn_wgClose,sess_ldapConn_messageMutex,child_SearchUser400);
	child_SearchUser400?0;
	stop_process: skip;
	child!0
}
proctype SearchUser40(Wgdef sess_ldapConn_wgClose;Mutexdef sess_ldapConn_messageMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close3051 = [1] of {int};
	chan child_SearchUser1392 = [1] of {int};
	chan child_Open1920 = [1] of {int};
	run Open192(sess_ldapConn_wgClose,sess_ldapConn_messageMutex,child_Open1920);
	child_Open1920?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run SearchUser139(sess_ldapConn_wgClose,sess_ldapConn_messageMutex,child_SearchUser1392);
	child_SearchUser1392?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		run Close305(sess_ldapConn_wgClose,sess_ldapConn_messageMutex,child_Close3051);
	child_Close3051?0;
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
proctype Close305(Wgdef s_ldapConn_wgClose;Mutexdef s_ldapConn_messageMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close3051 = [1] of {int};
	

	if
	:: true -> 
		run Close305(s_ldapConn_wgClose,s_ldapConn_messageMutex,child_Close3051);
		child_Close3051?0
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
	chan child_SearchLdap2252 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run SearchLdap225(s_ldapConn_wgClose,s_ldapConn_messageMutex,child_SearchLdap2252);
	child_SearchLdap2252?0;
	

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
	chan child_SearchLdapAttribute2422 = [1] of {int};
	run SearchLdapAttribute242(s_ldapConn_wgClose,s_ldapConn_messageMutex,child_SearchLdapAttribute2422);
	child_SearchLdapAttribute2422?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SearchLdapAttribute242(Wgdef s_ldapConn_wgClose;Mutexdef s_ldapConn_messageMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Bind1872 = [1] of {int};
	run Bind187(s_ldapConn_wgClose,s_ldapConn_messageMutex,child_Bind1872);
	child_Bind1872?0;
	

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
proctype Bind187(Wgdef s_ldapConn_wgClose;Mutexdef s_ldapConn_messageMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Bind1872 = [1] of {int};
	run Bind187(s_ldapConn_wgClose,s_ldapConn_messageMutex,child_Bind1872);
	child_Bind1872?0;
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

