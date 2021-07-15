
// https://github.com/kubernetes/kubernetes/blob/master/test/integration/master/transformation_testcase.go#L69
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newTransformTest690 = [1] of {int};
	run newTransformTest69(child_newTransformTest690)
stop_process:skip
}

proctype newTransformTest69(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_createNamespace2012 = [1] of {int};
	chan child_getEncryptionOptions1671 = [1] of {int};
	chan child_createEncryptionConfig1750 = [1] of {int};
	Mutexdef e_kubeAPIServer_EtcdClient_mu;
	Mutexdef e_kubeAPIServer_EtcdClient_resolverGroup_mu;
	Mutexdef e_kubeAPIServer_EtcdClient_cfg_TLS_mutex;
	Mutexdef e_kubeAPIServer_EtcdClient_conn_firstResolveEvent_o_m;
	Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_mu;
	Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_done_o_m;
	Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_scBuffer_mu;
	Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_balancerMu;
	Mutexdef e_kubeAPIServer_EtcdClient_conn_resolverWrapper_pollingMu;
	Mutexdef e_kubeAPIServer_EtcdClient_conn_resolverWrapper_done_o_m;
	Mutexdef e_kubeAPIServer_EtcdClient_conn_resolverWrapper_resolverMu;
	Mutexdef e_kubeAPIServer_EtcdClient_conn_mu;
	Mutexdef e_kubeAPIServer_EtcdClient_conn_blockingpicker_mu;
	Mutexdef e_kubeAPIServer_EtcdClient_conn_csMgr_mu;
	Mutexdef e_kubeAPIServer_ServerOpts_Admission_GenericAdmission_Plugins_lock;
	run mutexMonitor(e_kubeAPIServer_ServerOpts_Admission_GenericAdmission_Plugins_lock);
	run mutexMonitor(e_kubeAPIServer_EtcdClient_conn_csMgr_mu);
	run mutexMonitor(e_kubeAPIServer_EtcdClient_conn_blockingpicker_mu);
	run mutexMonitor(e_kubeAPIServer_EtcdClient_conn_mu);
	run mutexMonitor(e_kubeAPIServer_EtcdClient_conn_resolverWrapper_resolverMu);
	run mutexMonitor(e_kubeAPIServer_EtcdClient_conn_resolverWrapper_done_o_m);
	run mutexMonitor(e_kubeAPIServer_EtcdClient_conn_resolverWrapper_pollingMu);
	run mutexMonitor(e_kubeAPIServer_EtcdClient_conn_balancerWrapper_balancerMu);
	run mutexMonitor(e_kubeAPIServer_EtcdClient_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(e_kubeAPIServer_EtcdClient_conn_balancerWrapper_done_o_m);
	run mutexMonitor(e_kubeAPIServer_EtcdClient_conn_balancerWrapper_mu);
	run mutexMonitor(e_kubeAPIServer_EtcdClient_conn_firstResolveEvent_o_m);
	run mutexMonitor(e_kubeAPIServer_EtcdClient_cfg_TLS_mutex);
	run mutexMonitor(e_kubeAPIServer_EtcdClient_resolverGroup_mu);
	run mutexMonitor(e_kubeAPIServer_EtcdClient_mu);
	

	if
	:: true -> 
		run createEncryptionConfig175(e_kubeAPIServer_ServerOpts_Admission_GenericAdmission_Plugins_lock,e_kubeAPIServer_EtcdClient_conn_csMgr_mu,e_kubeAPIServer_EtcdClient_conn_blockingpicker_mu,e_kubeAPIServer_EtcdClient_conn_mu,e_kubeAPIServer_EtcdClient_conn_resolverWrapper_resolverMu,e_kubeAPIServer_EtcdClient_conn_resolverWrapper_done_o_m,e_kubeAPIServer_EtcdClient_conn_resolverWrapper_pollingMu,e_kubeAPIServer_EtcdClient_conn_balancerWrapper_balancerMu,e_kubeAPIServer_EtcdClient_conn_balancerWrapper_scBuffer_mu,e_kubeAPIServer_EtcdClient_conn_balancerWrapper_done_o_m,e_kubeAPIServer_EtcdClient_conn_balancerWrapper_mu,e_kubeAPIServer_EtcdClient_conn_firstResolveEvent_o_m,e_kubeAPIServer_EtcdClient_cfg_TLS_mutex,e_kubeAPIServer_EtcdClient_resolverGroup_mu,e_kubeAPIServer_EtcdClient_mu,child_createEncryptionConfig1750);
		child_createEncryptionConfig1750?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run getEncryptionOptions167(e_kubeAPIServer_ServerOpts_Admission_GenericAdmission_Plugins_lock,e_kubeAPIServer_EtcdClient_conn_csMgr_mu,e_kubeAPIServer_EtcdClient_conn_blockingpicker_mu,e_kubeAPIServer_EtcdClient_conn_mu,e_kubeAPIServer_EtcdClient_conn_resolverWrapper_resolverMu,e_kubeAPIServer_EtcdClient_conn_resolverWrapper_done_o_m,e_kubeAPIServer_EtcdClient_conn_resolverWrapper_pollingMu,e_kubeAPIServer_EtcdClient_conn_balancerWrapper_balancerMu,e_kubeAPIServer_EtcdClient_conn_balancerWrapper_scBuffer_mu,e_kubeAPIServer_EtcdClient_conn_balancerWrapper_done_o_m,e_kubeAPIServer_EtcdClient_conn_balancerWrapper_mu,e_kubeAPIServer_EtcdClient_conn_firstResolveEvent_o_m,e_kubeAPIServer_EtcdClient_cfg_TLS_mutex,e_kubeAPIServer_EtcdClient_resolverGroup_mu,e_kubeAPIServer_EtcdClient_mu,child_getEncryptionOptions1671);
	child_getEncryptionOptions1671?0;
	

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
	run createNamespace201(e_kubeAPIServer_ServerOpts_Admission_GenericAdmission_Plugins_lock,e_kubeAPIServer_EtcdClient_conn_csMgr_mu,e_kubeAPIServer_EtcdClient_conn_blockingpicker_mu,e_kubeAPIServer_EtcdClient_conn_mu,e_kubeAPIServer_EtcdClient_conn_resolverWrapper_resolverMu,e_kubeAPIServer_EtcdClient_conn_resolverWrapper_done_o_m,e_kubeAPIServer_EtcdClient_conn_resolverWrapper_pollingMu,e_kubeAPIServer_EtcdClient_conn_balancerWrapper_balancerMu,e_kubeAPIServer_EtcdClient_conn_balancerWrapper_scBuffer_mu,e_kubeAPIServer_EtcdClient_conn_balancerWrapper_done_o_m,e_kubeAPIServer_EtcdClient_conn_balancerWrapper_mu,e_kubeAPIServer_EtcdClient_conn_firstResolveEvent_o_m,e_kubeAPIServer_EtcdClient_cfg_TLS_mutex,e_kubeAPIServer_EtcdClient_resolverGroup_mu,e_kubeAPIServer_EtcdClient_mu,child_createNamespace2012);
	child_createNamespace2012?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype createEncryptionConfig175(Mutexdef e_kubeAPIServer_ServerOpts_Admission_GenericAdmission_Plugins_lock;Mutexdef e_kubeAPIServer_EtcdClient_conn_csMgr_mu;Mutexdef e_kubeAPIServer_EtcdClient_conn_blockingpicker_mu;Mutexdef e_kubeAPIServer_EtcdClient_conn_mu;Mutexdef e_kubeAPIServer_EtcdClient_conn_resolverWrapper_resolverMu;Mutexdef e_kubeAPIServer_EtcdClient_conn_resolverWrapper_done_o_m;Mutexdef e_kubeAPIServer_EtcdClient_conn_resolverWrapper_pollingMu;Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_balancerMu;Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_scBuffer_mu;Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_done_o_m;Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_mu;Mutexdef e_kubeAPIServer_EtcdClient_conn_firstResolveEvent_o_m;Mutexdef e_kubeAPIServer_EtcdClient_cfg_TLS_mutex;Mutexdef e_kubeAPIServer_EtcdClient_resolverGroup_mu;Mutexdef e_kubeAPIServer_EtcdClient_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
proctype getEncryptionOptions167(Mutexdef e_kubeAPIServer_ServerOpts_Admission_GenericAdmission_Plugins_lock;Mutexdef e_kubeAPIServer_EtcdClient_conn_csMgr_mu;Mutexdef e_kubeAPIServer_EtcdClient_conn_blockingpicker_mu;Mutexdef e_kubeAPIServer_EtcdClient_conn_mu;Mutexdef e_kubeAPIServer_EtcdClient_conn_resolverWrapper_resolverMu;Mutexdef e_kubeAPIServer_EtcdClient_conn_resolverWrapper_done_o_m;Mutexdef e_kubeAPIServer_EtcdClient_conn_resolverWrapper_pollingMu;Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_balancerMu;Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_scBuffer_mu;Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_done_o_m;Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_mu;Mutexdef e_kubeAPIServer_EtcdClient_conn_firstResolveEvent_o_m;Mutexdef e_kubeAPIServer_EtcdClient_cfg_TLS_mutex;Mutexdef e_kubeAPIServer_EtcdClient_resolverGroup_mu;Mutexdef e_kubeAPIServer_EtcdClient_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype createNamespace201(Mutexdef e_kubeAPIServer_ServerOpts_Admission_GenericAdmission_Plugins_lock;Mutexdef e_kubeAPIServer_EtcdClient_conn_csMgr_mu;Mutexdef e_kubeAPIServer_EtcdClient_conn_blockingpicker_mu;Mutexdef e_kubeAPIServer_EtcdClient_conn_mu;Mutexdef e_kubeAPIServer_EtcdClient_conn_resolverWrapper_resolverMu;Mutexdef e_kubeAPIServer_EtcdClient_conn_resolverWrapper_done_o_m;Mutexdef e_kubeAPIServer_EtcdClient_conn_resolverWrapper_pollingMu;Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_balancerMu;Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_scBuffer_mu;Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_done_o_m;Mutexdef e_kubeAPIServer_EtcdClient_conn_balancerWrapper_mu;Mutexdef e_kubeAPIServer_EtcdClient_conn_firstResolveEvent_o_m;Mutexdef e_kubeAPIServer_EtcdClient_cfg_TLS_mutex;Mutexdef e_kubeAPIServer_EtcdClient_resolverGroup_mu;Mutexdef e_kubeAPIServer_EtcdClient_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

