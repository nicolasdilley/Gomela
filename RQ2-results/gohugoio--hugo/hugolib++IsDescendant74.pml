
// https://github.com/gohugoio/hugo/blob/master/hugolib/page__tree.go#L74
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_IsDescendant740 = [1] of {int};
	run IsDescendant74(child_IsDescendant740)
stop_process:skip
}

proctype IsDescendant74(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ref2_m_s_init_taxonomies_init_mu;
	Mutexdef ref2_m_s_init_taxonomies_mu;
	Mutexdef ref2_m_s_init_menus_init_mu;
	Mutexdef ref2_m_s_init_menus_mu;
	Mutexdef ref2_m_s_init_prevNextInSection_init_mu;
	Mutexdef ref2_m_s_init_prevNextInSection_mu;
	Mutexdef ref2_m_s_init_prevNext_init_mu;
	Mutexdef ref2_m_s_init_prevNext_mu;
	Mutexdef ref2_m_s_relatedDocsHandler_mu;
	Mutexdef ref2_m_s_language_paramsMu;
	Mutexdef ref2_m_s_Info_language_paramsMu;
	Mutexdef ref2_m_s_Info_owner_init_translations_init_mu;
	Mutexdef ref2_m_s_Info_owner_init_translations_mu;
	Mutexdef ref2_m_s_Info_owner_init_gitInfo_init_mu;
	Mutexdef ref2_m_s_Info_owner_init_gitInfo_mu;
	Mutexdef ref2_m_s_Info_owner_init_layouts_init_mu;
	Mutexdef ref2_m_s_Info_owner_init_layouts_mu;
	Mutexdef ref2_m_s_Info_owner_init_data_init_mu;
	Mutexdef ref2_m_s_Info_owner_init_data_mu;
	Mutexdef ref2_m_s_Info_owner_skipRebuildForFilenamesMu;
	Mutexdef ref2_m_s_Info_owner_ContentChanges_symContentMu;
	Mutexdef ref2_m_s_Info_owner_ContentChanges_mu;
	Mutexdef ref2_m_s_Info_owner_contentInit_m;
	Mutexdef ref2_m_s_Info_owner_runningMu;
	Mutexdef ref2_m_s_Info_owner_multilingual_langMapInit_m;
	Mutexdef ref2_m_s_Info_owner_multilingual_DefaultLang_paramsMu;
	Mutexdef ref2_m_s_h_init_translations_init_mu;
	Mutexdef ref2_m_s_h_init_translations_mu;
	Mutexdef ref2_m_s_h_init_gitInfo_init_mu;
	Mutexdef ref2_m_s_h_init_gitInfo_mu;
	Mutexdef ref2_m_s_h_init_layouts_init_mu;
	Mutexdef ref2_m_s_h_init_layouts_mu;
	Mutexdef ref2_m_s_h_init_data_init_mu;
	Mutexdef ref2_m_s_h_init_data_mu;
	Mutexdef ref2_m_s_h_skipRebuildForFilenamesMu;
	Mutexdef ref2_m_s_h_ContentChanges_symContentMu;
	Mutexdef ref2_m_s_h_ContentChanges_mu;
	Mutexdef ref2_m_s_h_contentInit_m;
	Mutexdef ref2_m_s_h_runningMu;
	Mutexdef ref2_m_s_h_multilingual_langMapInit_m;
	Mutexdef ref2_m_s_h_multilingual_DefaultLang_paramsMu;
	Mutexdef ref1_m_s_init_taxonomies_init_mu;
	Mutexdef ref1_m_s_init_taxonomies_mu;
	Mutexdef ref1_m_s_init_menus_init_mu;
	Mutexdef ref1_m_s_init_menus_mu;
	Mutexdef ref1_m_s_init_prevNextInSection_init_mu;
	Mutexdef ref1_m_s_init_prevNextInSection_mu;
	Mutexdef ref1_m_s_init_prevNext_init_mu;
	Mutexdef ref1_m_s_init_prevNext_mu;
	Mutexdef ref1_m_s_relatedDocsHandler_mu;
	Mutexdef ref1_m_s_language_paramsMu;
	Mutexdef ref1_m_s_Info_language_paramsMu;
	Mutexdef ref1_m_s_Info_owner_init_translations_init_mu;
	Mutexdef ref1_m_s_Info_owner_init_translations_mu;
	Mutexdef ref1_m_s_Info_owner_init_gitInfo_init_mu;
	Mutexdef ref1_m_s_Info_owner_init_gitInfo_mu;
	Mutexdef ref1_m_s_Info_owner_init_layouts_init_mu;
	Mutexdef ref1_m_s_Info_owner_init_layouts_mu;
	Mutexdef ref1_m_s_Info_owner_init_data_init_mu;
	Mutexdef ref1_m_s_Info_owner_init_data_mu;
	Mutexdef ref1_m_s_Info_owner_skipRebuildForFilenamesMu;
	Mutexdef ref1_m_s_Info_owner_ContentChanges_symContentMu;
	Mutexdef ref1_m_s_Info_owner_ContentChanges_mu;
	Mutexdef ref1_m_s_Info_owner_contentInit_m;
	Mutexdef ref1_m_s_Info_owner_runningMu;
	Mutexdef ref1_m_s_Info_owner_multilingual_langMapInit_m;
	Mutexdef ref1_m_s_Info_owner_multilingual_DefaultLang_paramsMu;
	Mutexdef ref1_m_s_h_init_translations_init_mu;
	Mutexdef ref1_m_s_h_init_translations_mu;
	Mutexdef ref1_m_s_h_init_gitInfo_init_mu;
	Mutexdef ref1_m_s_h_init_gitInfo_mu;
	Mutexdef ref1_m_s_h_init_layouts_init_mu;
	Mutexdef ref1_m_s_h_init_layouts_mu;
	Mutexdef ref1_m_s_h_init_data_init_mu;
	Mutexdef ref1_m_s_h_init_data_mu;
	Mutexdef ref1_m_s_h_skipRebuildForFilenamesMu;
	Mutexdef ref1_m_s_h_ContentChanges_symContentMu;
	Mutexdef ref1_m_s_h_ContentChanges_mu;
	Mutexdef ref1_m_s_h_contentInit_m;
	Mutexdef ref1_m_s_h_runningMu;
	Mutexdef ref1_m_s_h_multilingual_langMapInit_m;
	Mutexdef ref1_m_s_h_multilingual_DefaultLang_paramsMu;
	

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
	run mutexMonitor(ref1_m_s_h_multilingual_DefaultLang_paramsMu);
	run mutexMonitor(ref1_m_s_h_multilingual_langMapInit_m);
	run mutexMonitor(ref1_m_s_h_runningMu);
	run mutexMonitor(ref1_m_s_h_contentInit_m);
	run mutexMonitor(ref1_m_s_h_ContentChanges_mu);
	run mutexMonitor(ref1_m_s_h_ContentChanges_symContentMu);
	run mutexMonitor(ref1_m_s_h_skipRebuildForFilenamesMu);
	run mutexMonitor(ref1_m_s_h_init_data_mu);
	run mutexMonitor(ref1_m_s_h_init_data_init_mu);
	run mutexMonitor(ref1_m_s_h_init_layouts_mu);
	run mutexMonitor(ref1_m_s_h_init_layouts_init_mu);
	run mutexMonitor(ref1_m_s_h_init_gitInfo_mu);
	run mutexMonitor(ref1_m_s_h_init_gitInfo_init_mu);
	run mutexMonitor(ref1_m_s_h_init_translations_mu);
	run mutexMonitor(ref1_m_s_h_init_translations_init_mu);
	run mutexMonitor(ref1_m_s_Info_owner_multilingual_DefaultLang_paramsMu);
	run mutexMonitor(ref1_m_s_Info_owner_multilingual_langMapInit_m);
	run mutexMonitor(ref1_m_s_Info_owner_runningMu);
	run mutexMonitor(ref1_m_s_Info_owner_contentInit_m);
	run mutexMonitor(ref1_m_s_Info_owner_ContentChanges_mu);
	run mutexMonitor(ref1_m_s_Info_owner_ContentChanges_symContentMu);
	run mutexMonitor(ref1_m_s_Info_owner_skipRebuildForFilenamesMu);
	run mutexMonitor(ref1_m_s_Info_owner_init_data_mu);
	run mutexMonitor(ref1_m_s_Info_owner_init_data_init_mu);
	run mutexMonitor(ref1_m_s_Info_owner_init_layouts_mu);
	run mutexMonitor(ref1_m_s_Info_owner_init_layouts_init_mu);
	run mutexMonitor(ref1_m_s_Info_owner_init_gitInfo_mu);
	run mutexMonitor(ref1_m_s_Info_owner_init_gitInfo_init_mu);
	run mutexMonitor(ref1_m_s_Info_owner_init_translations_mu);
	run mutexMonitor(ref1_m_s_Info_owner_init_translations_init_mu);
	run mutexMonitor(ref1_m_s_Info_language_paramsMu);
	run mutexMonitor(ref1_m_s_language_paramsMu);
	run mutexMonitor(ref1_m_s_relatedDocsHandler_mu);
	run mutexMonitor(ref1_m_s_init_prevNext_mu);
	run mutexMonitor(ref1_m_s_init_prevNext_init_mu);
	run mutexMonitor(ref1_m_s_init_prevNextInSection_mu);
	run mutexMonitor(ref1_m_s_init_prevNextInSection_init_mu);
	run mutexMonitor(ref1_m_s_init_menus_mu);
	run mutexMonitor(ref1_m_s_init_menus_init_mu);
	run mutexMonitor(ref1_m_s_init_taxonomies_mu);
	run mutexMonitor(ref1_m_s_init_taxonomies_init_mu);
	run mutexMonitor(ref2_m_s_h_multilingual_DefaultLang_paramsMu);
	run mutexMonitor(ref2_m_s_h_multilingual_langMapInit_m);
	run mutexMonitor(ref2_m_s_h_runningMu);
	run mutexMonitor(ref2_m_s_h_contentInit_m);
	run mutexMonitor(ref2_m_s_h_ContentChanges_mu);
	run mutexMonitor(ref2_m_s_h_ContentChanges_symContentMu);
	run mutexMonitor(ref2_m_s_h_skipRebuildForFilenamesMu);
	run mutexMonitor(ref2_m_s_h_init_data_mu);
	run mutexMonitor(ref2_m_s_h_init_data_init_mu);
	run mutexMonitor(ref2_m_s_h_init_layouts_mu);
	run mutexMonitor(ref2_m_s_h_init_layouts_init_mu);
	run mutexMonitor(ref2_m_s_h_init_gitInfo_mu);
	run mutexMonitor(ref2_m_s_h_init_gitInfo_init_mu);
	run mutexMonitor(ref2_m_s_h_init_translations_mu);
	run mutexMonitor(ref2_m_s_h_init_translations_init_mu);
	run mutexMonitor(ref2_m_s_Info_owner_multilingual_DefaultLang_paramsMu);
	run mutexMonitor(ref2_m_s_Info_owner_multilingual_langMapInit_m);
	run mutexMonitor(ref2_m_s_Info_owner_runningMu);
	run mutexMonitor(ref2_m_s_Info_owner_contentInit_m);
	run mutexMonitor(ref2_m_s_Info_owner_ContentChanges_mu);
	run mutexMonitor(ref2_m_s_Info_owner_ContentChanges_symContentMu);
	run mutexMonitor(ref2_m_s_Info_owner_skipRebuildForFilenamesMu);
	run mutexMonitor(ref2_m_s_Info_owner_init_data_mu);
	run mutexMonitor(ref2_m_s_Info_owner_init_data_init_mu);
	run mutexMonitor(ref2_m_s_Info_owner_init_layouts_mu);
	run mutexMonitor(ref2_m_s_Info_owner_init_layouts_init_mu);
	run mutexMonitor(ref2_m_s_Info_owner_init_gitInfo_mu);
	run mutexMonitor(ref2_m_s_Info_owner_init_gitInfo_init_mu);
	run mutexMonitor(ref2_m_s_Info_owner_init_translations_mu);
	run mutexMonitor(ref2_m_s_Info_owner_init_translations_init_mu);
	run mutexMonitor(ref2_m_s_Info_language_paramsMu);
	run mutexMonitor(ref2_m_s_language_paramsMu);
	run mutexMonitor(ref2_m_s_relatedDocsHandler_mu);
	run mutexMonitor(ref2_m_s_init_prevNext_mu);
	run mutexMonitor(ref2_m_s_init_prevNext_init_mu);
	run mutexMonitor(ref2_m_s_init_prevNextInSection_mu);
	run mutexMonitor(ref2_m_s_init_prevNextInSection_init_mu);
	run mutexMonitor(ref2_m_s_init_menus_mu);
	run mutexMonitor(ref2_m_s_init_menus_init_mu);
	run mutexMonitor(ref2_m_s_init_taxonomies_mu);
	run mutexMonitor(ref2_m_s_init_taxonomies_init_mu);
	

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
		fi;
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

