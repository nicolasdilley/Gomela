
// https://github.com/gohugoio/hugo/blob/master/hugolib/site_test.go#L897
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRefLinking8970 = [1] of {int};
	run TestRefLinking897(child_TestRefLinking8970)
stop_process:skip
}

proctype TestRefLinking897(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getPage5320 = [1] of {int};
	Mutexdef site_init_taxonomies_init_mu;
	Mutexdef site_init_taxonomies_mu;
	Mutexdef site_init_menus_init_mu;
	Mutexdef site_init_menus_mu;
	Mutexdef site_init_prevNextInSection_init_mu;
	Mutexdef site_init_prevNextInSection_mu;
	Mutexdef site_init_prevNext_init_mu;
	Mutexdef site_init_prevNext_mu;
	Mutexdef site_relatedDocsHandler_mu;
	Mutexdef site_language_paramsMu;
	Mutexdef site_Info_language_paramsMu;
	Mutexdef site_Info_owner_init_translations_init_mu;
	Mutexdef site_Info_owner_init_translations_mu;
	Mutexdef site_Info_owner_init_gitInfo_init_mu;
	Mutexdef site_Info_owner_init_gitInfo_mu;
	Mutexdef site_Info_owner_init_layouts_init_mu;
	Mutexdef site_Info_owner_init_layouts_mu;
	Mutexdef site_Info_owner_init_data_init_mu;
	Mutexdef site_Info_owner_init_data_mu;
	Mutexdef site_Info_owner_skipRebuildForFilenamesMu;
	Mutexdef site_Info_owner_ContentChanges_symContentMu;
	Mutexdef site_Info_owner_ContentChanges_mu;
	Mutexdef site_Info_owner_contentInit_m;
	Mutexdef site_Info_owner_runningMu;
	Mutexdef site_Info_owner_multilingual_langMapInit_m;
	Mutexdef site_Info_owner_multilingual_DefaultLang_paramsMu;
	Mutexdef site_h_init_translations_init_mu;
	Mutexdef site_h_init_translations_mu;
	Mutexdef site_h_init_gitInfo_init_mu;
	Mutexdef site_h_init_gitInfo_mu;
	Mutexdef site_h_init_layouts_init_mu;
	Mutexdef site_h_init_layouts_mu;
	Mutexdef site_h_init_data_init_mu;
	Mutexdef site_h_init_data_mu;
	Mutexdef site_h_skipRebuildForFilenamesMu;
	Mutexdef site_h_ContentChanges_symContentMu;
	Mutexdef site_h_ContentChanges_mu;
	Mutexdef site_h_contentInit_m;
	Mutexdef site_h_runningMu;
	Mutexdef site_h_multilingual_langMapInit_m;
	Mutexdef site_h_multilingual_DefaultLang_paramsMu;
	run mutexMonitor(site_h_multilingual_DefaultLang_paramsMu);
	run mutexMonitor(site_h_multilingual_langMapInit_m);
	run mutexMonitor(site_h_runningMu);
	run mutexMonitor(site_h_contentInit_m);
	run mutexMonitor(site_h_ContentChanges_mu);
	run mutexMonitor(site_h_ContentChanges_symContentMu);
	run mutexMonitor(site_h_skipRebuildForFilenamesMu);
	run mutexMonitor(site_h_init_data_mu);
	run mutexMonitor(site_h_init_data_init_mu);
	run mutexMonitor(site_h_init_layouts_mu);
	run mutexMonitor(site_h_init_layouts_init_mu);
	run mutexMonitor(site_h_init_gitInfo_mu);
	run mutexMonitor(site_h_init_gitInfo_init_mu);
	run mutexMonitor(site_h_init_translations_mu);
	run mutexMonitor(site_h_init_translations_init_mu);
	run mutexMonitor(site_Info_owner_multilingual_DefaultLang_paramsMu);
	run mutexMonitor(site_Info_owner_multilingual_langMapInit_m);
	run mutexMonitor(site_Info_owner_runningMu);
	run mutexMonitor(site_Info_owner_contentInit_m);
	run mutexMonitor(site_Info_owner_ContentChanges_mu);
	run mutexMonitor(site_Info_owner_ContentChanges_symContentMu);
	run mutexMonitor(site_Info_owner_skipRebuildForFilenamesMu);
	run mutexMonitor(site_Info_owner_init_data_mu);
	run mutexMonitor(site_Info_owner_init_data_init_mu);
	run mutexMonitor(site_Info_owner_init_layouts_mu);
	run mutexMonitor(site_Info_owner_init_layouts_init_mu);
	run mutexMonitor(site_Info_owner_init_gitInfo_mu);
	run mutexMonitor(site_Info_owner_init_gitInfo_init_mu);
	run mutexMonitor(site_Info_owner_init_translations_mu);
	run mutexMonitor(site_Info_owner_init_translations_init_mu);
	run mutexMonitor(site_Info_language_paramsMu);
	run mutexMonitor(site_language_paramsMu);
	run mutexMonitor(site_relatedDocsHandler_mu);
	run mutexMonitor(site_init_prevNext_mu);
	run mutexMonitor(site_init_prevNext_init_mu);
	run mutexMonitor(site_init_prevNextInSection_mu);
	run mutexMonitor(site_init_prevNextInSection_init_mu);
	run mutexMonitor(site_init_menus_mu);
	run mutexMonitor(site_init_menus_init_mu);
	run mutexMonitor(site_init_taxonomies_mu);
	run mutexMonitor(site_init_taxonomies_init_mu);
	run getPage532(site_h_multilingual_DefaultLang_paramsMu,site_h_multilingual_langMapInit_m,site_h_runningMu,site_h_contentInit_m,site_h_ContentChanges_mu,site_h_ContentChanges_symContentMu,site_h_skipRebuildForFilenamesMu,site_h_init_data_mu,site_h_init_data_init_mu,site_h_init_layouts_mu,site_h_init_layouts_init_mu,site_h_init_gitInfo_mu,site_h_init_gitInfo_init_mu,site_h_init_translations_mu,site_h_init_translations_init_mu,site_Info_owner_multilingual_DefaultLang_paramsMu,site_Info_owner_multilingual_langMapInit_m,site_Info_owner_runningMu,site_Info_owner_contentInit_m,site_Info_owner_ContentChanges_mu,site_Info_owner_ContentChanges_symContentMu,site_Info_owner_skipRebuildForFilenamesMu,site_Info_owner_init_data_mu,site_Info_owner_init_data_init_mu,site_Info_owner_init_layouts_mu,site_Info_owner_init_layouts_init_mu,site_Info_owner_init_gitInfo_mu,site_Info_owner_init_gitInfo_init_mu,site_Info_owner_init_translations_mu,site_Info_owner_init_translations_init_mu,site_Info_language_paramsMu,site_language_paramsMu,site_relatedDocsHandler_mu,site_init_prevNext_mu,site_init_prevNext_init_mu,site_init_prevNextInSection_mu,site_init_prevNextInSection_init_mu,site_init_menus_mu,site_init_menus_init_mu,site_init_taxonomies_mu,site_init_taxonomies_init_mu,child_getPage5320);
	child_getPage5320?0;
	stop_process: skip;
	child!0
}
proctype getPage532(Mutexdef m_h_multilingual_DefaultLang_paramsMu;Mutexdef m_h_multilingual_langMapInit_m;Mutexdef m_h_runningMu;Mutexdef m_h_contentInit_m;Mutexdef m_h_ContentChanges_mu;Mutexdef m_h_ContentChanges_symContentMu;Mutexdef m_h_skipRebuildForFilenamesMu;Mutexdef m_h_init_data_mu;Mutexdef m_h_init_data_init_mu;Mutexdef m_h_init_layouts_mu;Mutexdef m_h_init_layouts_init_mu;Mutexdef m_h_init_gitInfo_mu;Mutexdef m_h_init_gitInfo_init_mu;Mutexdef m_h_init_translations_mu;Mutexdef m_h_init_translations_init_mu;Mutexdef m_Info_owner_multilingual_DefaultLang_paramsMu;Mutexdef m_Info_owner_multilingual_langMapInit_m;Mutexdef m_Info_owner_runningMu;Mutexdef m_Info_owner_contentInit_m;Mutexdef m_Info_owner_ContentChanges_mu;Mutexdef m_Info_owner_ContentChanges_symContentMu;Mutexdef m_Info_owner_skipRebuildForFilenamesMu;Mutexdef m_Info_owner_init_data_mu;Mutexdef m_Info_owner_init_data_init_mu;Mutexdef m_Info_owner_init_layouts_mu;Mutexdef m_Info_owner_init_layouts_init_mu;Mutexdef m_Info_owner_init_gitInfo_mu;Mutexdef m_Info_owner_init_gitInfo_init_mu;Mutexdef m_Info_owner_init_translations_mu;Mutexdef m_Info_owner_init_translations_init_mu;Mutexdef m_Info_language_paramsMu;Mutexdef m_language_paramsMu;Mutexdef m_relatedDocsHandler_mu;Mutexdef m_init_prevNext_mu;Mutexdef m_init_prevNext_init_mu;Mutexdef m_init_prevNextInSection_mu;Mutexdef m_init_prevNextInSection_init_mu;Mutexdef m_init_menus_mu;Mutexdef m_init_menus_init_mu;Mutexdef m_init_taxonomies_mu;Mutexdef m_init_taxonomies_init_mu;chan child) {
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

