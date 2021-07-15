
// https://github.com/jaegertracing/jaeger/blob/master/cmd/query/app/server_test.go#L58
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
	chan child_TestCreateTLSServerSinglePortError580 = [1] of {int};
	run TestCreateTLSServerSinglePortError58(child_TestCreateTLSServerSinglePortError580)
stop_process:skip
}

proctype TestCreateTLSServerSinglePortError58(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __httpServer_mu;
	Mutexdef __httpServer_nextProtoOnce_m;
	Mutexdef __httpServer_ErrorLog_mu;
	Mutexdef __httpServer_TLSConfig_mutex;
	Wgdef __grpcServer_serveWG;
	Mutexdef __grpcServer_channelzRemoveOnce_m;
	Mutexdef __grpcServer_done_o_m;
	Mutexdef __grpcServer_quit_o_m;
	Mutexdef __grpcServer_mu;
	Mutexdef __queryOptions_TLSHTTP_certWatcher_mu;
	Mutexdef __queryOptions_TLSHTTP_certWatcher_watcher_mu;
	Mutexdef __queryOptions_TLSGRPC_certWatcher_mu;
	Mutexdef __queryOptions_TLSGRPC_certWatcher_watcher_mu;
	Mutexdef tlsCfg_certWatcher_mu;
	Mutexdef tlsCfg_certWatcher_watcher_mu;
	run mutexMonitor(tlsCfg_certWatcher_watcher_mu);
	run mutexMonitor(tlsCfg_certWatcher_mu);
	run mutexMonitor(__queryOptions_TLSGRPC_certWatcher_watcher_mu);
	run mutexMonitor(__queryOptions_TLSGRPC_certWatcher_mu);
	run mutexMonitor(__queryOptions_TLSHTTP_certWatcher_watcher_mu);
	run mutexMonitor(__queryOptions_TLSHTTP_certWatcher_mu);
	run mutexMonitor(__grpcServer_mu);
	run mutexMonitor(__grpcServer_quit_o_m);
	run mutexMonitor(__grpcServer_done_o_m);
	run mutexMonitor(__grpcServer_channelzRemoveOnce_m);
	run wgMonitor(__grpcServer_serveWG);
	run mutexMonitor(__httpServer_TLSConfig_mutex);
	run mutexMonitor(__httpServer_ErrorLog_mu);
	run mutexMonitor(__httpServer_nextProtoOnce_m);
	run mutexMonitor(__httpServer_mu);
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

