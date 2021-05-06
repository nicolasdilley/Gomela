
// https://github.com/gohugoio/hugo/blob/master/hugolib/site.go#L627
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewSiteForCfg6270 = [1] of {int};
	run NewSiteForCfg627(child_NewSiteForCfg6270)
stop_process:skip
}

proctype NewSiteForCfg627(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef h_init_translations_init_mu;
	Mutexdef h_init_translations_mu;
	Mutexdef h_init_gitInfo_init_mu;
	Mutexdef h_init_gitInfo_mu;
	Mutexdef h_init_layouts_init_mu;
	Mutexdef h_init_layouts_mu;
	Mutexdef h_init_data_init_mu;
	Mutexdef h_init_data_mu;
	Mutexdef h_skipRebuildForFilenamesMu;
	Mutexdef h_ContentChanges_symContentMu;
	Mutexdef h_ContentChanges_mu;
	Mutexdef h_contentInit_m;
	Mutexdef h_runningMu;
	Mutexdef h_multilingual_langMapInit_m;
	Mutexdef h_multilingual_DefaultLang_paramsMu;
	run mutexMonitor(h_multilingual_DefaultLang_paramsMu);
	run mutexMonitor(h_multilingual_langMapInit_m);
	run mutexMonitor(h_runningMu);
	run mutexMonitor(h_contentInit_m);
	run mutexMonitor(h_ContentChanges_mu);
	run mutexMonitor(h_ContentChanges_symContentMu);
	run mutexMonitor(h_skipRebuildForFilenamesMu);
	run mutexMonitor(h_init_data_mu);
	run mutexMonitor(h_init_data_init_mu);
	run mutexMonitor(h_init_layouts_mu);
	run mutexMonitor(h_init_layouts_init_mu);
	run mutexMonitor(h_init_gitInfo_mu);
	run mutexMonitor(h_init_gitInfo_init_mu);
	run mutexMonitor(h_init_translations_mu);
	run mutexMonitor(h_init_translations_init_mu);
	

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

