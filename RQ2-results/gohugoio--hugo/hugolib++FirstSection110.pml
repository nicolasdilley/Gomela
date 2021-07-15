
// https://github.com/gohugoio/hugo/blob/master/hugolib/page__tree.go#L110
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_FirstSection1100 = [1] of {int};
	run FirstSection110(child_FirstSection1100)
stop_process:skip
}

proctype FirstSection110(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getFirstSection4831 = [1] of {int};
	chan child_isSection9590 = [1] of {int};
	Mutexdef ref_m_s_init_taxonomies_init_mu;
	Mutexdef ref_m_s_init_taxonomies_mu;
	Mutexdef ref_m_s_init_menus_init_mu;
	Mutexdef ref_m_s_init_menus_mu;
	Mutexdef ref_m_s_init_prevNextInSection_init_mu;
	Mutexdef ref_m_s_init_prevNextInSection_mu;
	Mutexdef ref_m_s_init_prevNext_init_mu;
	Mutexdef ref_m_s_init_prevNext_mu;
	Mutexdef ref_m_s_relatedDocsHandler_mu;
	Mutexdef ref_m_s_language_paramsMu;
	Mutexdef ref_m_s_Info_language_paramsMu;
	Mutexdef ref_m_s_Info_owner_init_translations_init_mu;
	Mutexdef ref_m_s_Info_owner_init_translations_mu;
	Mutexdef ref_m_s_Info_owner_init_gitInfo_init_mu;
	Mutexdef ref_m_s_Info_owner_init_gitInfo_mu;
	Mutexdef ref_m_s_Info_owner_init_layouts_init_mu;
	Mutexdef ref_m_s_Info_owner_init_layouts_mu;
	Mutexdef ref_m_s_Info_owner_init_data_init_mu;
	Mutexdef ref_m_s_Info_owner_init_data_mu;
	Mutexdef ref_m_s_Info_owner_skipRebuildForFilenamesMu;
	Mutexdef ref_m_s_Info_owner_ContentChanges_symContentMu;
	Mutexdef ref_m_s_Info_owner_ContentChanges_mu;
	Mutexdef ref_m_s_Info_owner_contentInit_m;
	Mutexdef ref_m_s_Info_owner_runningMu;
	Mutexdef ref_m_s_Info_owner_multilingual_langMapInit_m;
	Mutexdef ref_m_s_Info_owner_multilingual_DefaultLang_paramsMu;
	Mutexdef ref_m_s_h_init_translations_init_mu;
	Mutexdef ref_m_s_h_init_translations_mu;
	Mutexdef ref_m_s_h_init_gitInfo_init_mu;
	Mutexdef ref_m_s_h_init_gitInfo_mu;
	Mutexdef ref_m_s_h_init_layouts_init_mu;
	Mutexdef ref_m_s_h_init_layouts_mu;
	Mutexdef ref_m_s_h_init_data_init_mu;
	Mutexdef ref_m_s_h_init_data_mu;
	Mutexdef ref_m_s_h_skipRebuildForFilenamesMu;
	Mutexdef ref_m_s_h_ContentChanges_symContentMu;
	Mutexdef ref_m_s_h_ContentChanges_mu;
	Mutexdef ref_m_s_h_contentInit_m;
	Mutexdef ref_m_s_h_runningMu;
	Mutexdef ref_m_s_h_multilingual_langMapInit_m;
	Mutexdef ref_m_s_h_multilingual_DefaultLang_paramsMu;
	run mutexMonitor(ref_m_s_h_multilingual_DefaultLang_paramsMu);
	run mutexMonitor(ref_m_s_h_multilingual_langMapInit_m);
	run mutexMonitor(ref_m_s_h_runningMu);
	run mutexMonitor(ref_m_s_h_contentInit_m);
	run mutexMonitor(ref_m_s_h_ContentChanges_mu);
	run mutexMonitor(ref_m_s_h_ContentChanges_symContentMu);
	run mutexMonitor(ref_m_s_h_skipRebuildForFilenamesMu);
	run mutexMonitor(ref_m_s_h_init_data_mu);
	run mutexMonitor(ref_m_s_h_init_data_init_mu);
	run mutexMonitor(ref_m_s_h_init_layouts_mu);
	run mutexMonitor(ref_m_s_h_init_layouts_init_mu);
	run mutexMonitor(ref_m_s_h_init_gitInfo_mu);
	run mutexMonitor(ref_m_s_h_init_gitInfo_init_mu);
	run mutexMonitor(ref_m_s_h_init_translations_mu);
	run mutexMonitor(ref_m_s_h_init_translations_init_mu);
	run mutexMonitor(ref_m_s_Info_owner_multilingual_DefaultLang_paramsMu);
	run mutexMonitor(ref_m_s_Info_owner_multilingual_langMapInit_m);
	run mutexMonitor(ref_m_s_Info_owner_runningMu);
	run mutexMonitor(ref_m_s_Info_owner_contentInit_m);
	run mutexMonitor(ref_m_s_Info_owner_ContentChanges_mu);
	run mutexMonitor(ref_m_s_Info_owner_ContentChanges_symContentMu);
	run mutexMonitor(ref_m_s_Info_owner_skipRebuildForFilenamesMu);
	run mutexMonitor(ref_m_s_Info_owner_init_data_mu);
	run mutexMonitor(ref_m_s_Info_owner_init_data_init_mu);
	run mutexMonitor(ref_m_s_Info_owner_init_layouts_mu);
	run mutexMonitor(ref_m_s_Info_owner_init_layouts_init_mu);
	run mutexMonitor(ref_m_s_Info_owner_init_gitInfo_mu);
	run mutexMonitor(ref_m_s_Info_owner_init_gitInfo_init_mu);
	run mutexMonitor(ref_m_s_Info_owner_init_translations_mu);
	run mutexMonitor(ref_m_s_Info_owner_init_translations_init_mu);
	run mutexMonitor(ref_m_s_Info_language_paramsMu);
	run mutexMonitor(ref_m_s_language_paramsMu);
	run mutexMonitor(ref_m_s_relatedDocsHandler_mu);
	run mutexMonitor(ref_m_s_init_prevNext_mu);
	run mutexMonitor(ref_m_s_init_prevNext_init_mu);
	run mutexMonitor(ref_m_s_init_prevNextInSection_mu);
	run mutexMonitor(ref_m_s_init_prevNextInSection_init_mu);
	run mutexMonitor(ref_m_s_init_menus_mu);
	run mutexMonitor(ref_m_s_init_menus_init_mu);
	run mutexMonitor(ref_m_s_init_taxonomies_mu);
	run mutexMonitor(ref_m_s_init_taxonomies_init_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run isSection959(ref_m_s_h_multilingual_DefaultLang_paramsMu,ref_m_s_h_multilingual_langMapInit_m,ref_m_s_h_runningMu,ref_m_s_h_contentInit_m,ref_m_s_h_ContentChanges_mu,ref_m_s_h_ContentChanges_symContentMu,ref_m_s_h_skipRebuildForFilenamesMu,ref_m_s_h_init_data_mu,ref_m_s_h_init_data_init_mu,ref_m_s_h_init_layouts_mu,ref_m_s_h_init_layouts_init_mu,ref_m_s_h_init_gitInfo_mu,ref_m_s_h_init_gitInfo_init_mu,ref_m_s_h_init_translations_mu,ref_m_s_h_init_translations_init_mu,ref_m_s_Info_owner_multilingual_DefaultLang_paramsMu,ref_m_s_Info_owner_multilingual_langMapInit_m,ref_m_s_Info_owner_runningMu,ref_m_s_Info_owner_contentInit_m,ref_m_s_Info_owner_ContentChanges_mu,ref_m_s_Info_owner_ContentChanges_symContentMu,ref_m_s_Info_owner_skipRebuildForFilenamesMu,ref_m_s_Info_owner_init_data_mu,ref_m_s_Info_owner_init_data_init_mu,ref_m_s_Info_owner_init_layouts_mu,ref_m_s_Info_owner_init_layouts_init_mu,ref_m_s_Info_owner_init_gitInfo_mu,ref_m_s_Info_owner_init_gitInfo_init_mu,ref_m_s_Info_owner_init_translations_mu,ref_m_s_Info_owner_init_translations_init_mu,ref_m_s_Info_language_paramsMu,ref_m_s_language_paramsMu,ref_m_s_relatedDocsHandler_mu,ref_m_s_init_prevNext_mu,ref_m_s_init_prevNext_init_mu,ref_m_s_init_prevNextInSection_mu,ref_m_s_init_prevNextInSection_init_mu,ref_m_s_init_menus_mu,ref_m_s_init_menus_init_mu,ref_m_s_init_taxonomies_mu,ref_m_s_init_taxonomies_init_mu,child_isSection9590);
	child_isSection9590?0;
	run getFirstSection483(ref_m_s_h_multilingual_DefaultLang_paramsMu,ref_m_s_h_multilingual_langMapInit_m,ref_m_s_h_runningMu,ref_m_s_h_contentInit_m,ref_m_s_h_ContentChanges_mu,ref_m_s_h_ContentChanges_symContentMu,ref_m_s_h_skipRebuildForFilenamesMu,ref_m_s_h_init_data_mu,ref_m_s_h_init_data_init_mu,ref_m_s_h_init_layouts_mu,ref_m_s_h_init_layouts_init_mu,ref_m_s_h_init_gitInfo_mu,ref_m_s_h_init_gitInfo_init_mu,ref_m_s_h_init_translations_mu,ref_m_s_h_init_translations_init_mu,ref_m_s_Info_owner_multilingual_DefaultLang_paramsMu,ref_m_s_Info_owner_multilingual_langMapInit_m,ref_m_s_Info_owner_runningMu,ref_m_s_Info_owner_contentInit_m,ref_m_s_Info_owner_ContentChanges_mu,ref_m_s_Info_owner_ContentChanges_symContentMu,ref_m_s_Info_owner_skipRebuildForFilenamesMu,ref_m_s_Info_owner_init_data_mu,ref_m_s_Info_owner_init_data_init_mu,ref_m_s_Info_owner_init_layouts_mu,ref_m_s_Info_owner_init_layouts_init_mu,ref_m_s_Info_owner_init_gitInfo_mu,ref_m_s_Info_owner_init_gitInfo_init_mu,ref_m_s_Info_owner_init_translations_mu,ref_m_s_Info_owner_init_translations_init_mu,ref_m_s_Info_language_paramsMu,ref_m_s_language_paramsMu,ref_m_s_relatedDocsHandler_mu,ref_m_s_init_prevNext_mu,ref_m_s_init_prevNext_init_mu,ref_m_s_init_prevNextInSection_mu,ref_m_s_init_prevNextInSection_init_mu,ref_m_s_init_menus_mu,ref_m_s_init_menus_init_mu,ref_m_s_init_taxonomies_mu,ref_m_s_init_taxonomies_init_mu,child_getFirstSection4831);
	child_getFirstSection4831?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype isSection959(Mutexdef c_m_s_h_multilingual_DefaultLang_paramsMu;Mutexdef c_m_s_h_multilingual_langMapInit_m;Mutexdef c_m_s_h_runningMu;Mutexdef c_m_s_h_contentInit_m;Mutexdef c_m_s_h_ContentChanges_mu;Mutexdef c_m_s_h_ContentChanges_symContentMu;Mutexdef c_m_s_h_skipRebuildForFilenamesMu;Mutexdef c_m_s_h_init_data_mu;Mutexdef c_m_s_h_init_data_init_mu;Mutexdef c_m_s_h_init_layouts_mu;Mutexdef c_m_s_h_init_layouts_init_mu;Mutexdef c_m_s_h_init_gitInfo_mu;Mutexdef c_m_s_h_init_gitInfo_init_mu;Mutexdef c_m_s_h_init_translations_mu;Mutexdef c_m_s_h_init_translations_init_mu;Mutexdef c_m_s_Info_owner_multilingual_DefaultLang_paramsMu;Mutexdef c_m_s_Info_owner_multilingual_langMapInit_m;Mutexdef c_m_s_Info_owner_runningMu;Mutexdef c_m_s_Info_owner_contentInit_m;Mutexdef c_m_s_Info_owner_ContentChanges_mu;Mutexdef c_m_s_Info_owner_ContentChanges_symContentMu;Mutexdef c_m_s_Info_owner_skipRebuildForFilenamesMu;Mutexdef c_m_s_Info_owner_init_data_mu;Mutexdef c_m_s_Info_owner_init_data_init_mu;Mutexdef c_m_s_Info_owner_init_layouts_mu;Mutexdef c_m_s_Info_owner_init_layouts_init_mu;Mutexdef c_m_s_Info_owner_init_gitInfo_mu;Mutexdef c_m_s_Info_owner_init_gitInfo_init_mu;Mutexdef c_m_s_Info_owner_init_translations_mu;Mutexdef c_m_s_Info_owner_init_translations_init_mu;Mutexdef c_m_s_Info_language_paramsMu;Mutexdef c_m_s_language_paramsMu;Mutexdef c_m_s_relatedDocsHandler_mu;Mutexdef c_m_s_init_prevNext_mu;Mutexdef c_m_s_init_prevNext_init_mu;Mutexdef c_m_s_init_prevNextInSection_mu;Mutexdef c_m_s_init_prevNextInSection_init_mu;Mutexdef c_m_s_init_menus_mu;Mutexdef c_m_s_init_menus_init_mu;Mutexdef c_m_s_init_taxonomies_mu;Mutexdef c_m_s_init_taxonomies_init_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getFirstSection483(Mutexdef m_s_h_multilingual_DefaultLang_paramsMu;Mutexdef m_s_h_multilingual_langMapInit_m;Mutexdef m_s_h_runningMu;Mutexdef m_s_h_contentInit_m;Mutexdef m_s_h_ContentChanges_mu;Mutexdef m_s_h_ContentChanges_symContentMu;Mutexdef m_s_h_skipRebuildForFilenamesMu;Mutexdef m_s_h_init_data_mu;Mutexdef m_s_h_init_data_init_mu;Mutexdef m_s_h_init_layouts_mu;Mutexdef m_s_h_init_layouts_init_mu;Mutexdef m_s_h_init_gitInfo_mu;Mutexdef m_s_h_init_gitInfo_init_mu;Mutexdef m_s_h_init_translations_mu;Mutexdef m_s_h_init_translations_init_mu;Mutexdef m_s_Info_owner_multilingual_DefaultLang_paramsMu;Mutexdef m_s_Info_owner_multilingual_langMapInit_m;Mutexdef m_s_Info_owner_runningMu;Mutexdef m_s_Info_owner_contentInit_m;Mutexdef m_s_Info_owner_ContentChanges_mu;Mutexdef m_s_Info_owner_ContentChanges_symContentMu;Mutexdef m_s_Info_owner_skipRebuildForFilenamesMu;Mutexdef m_s_Info_owner_init_data_mu;Mutexdef m_s_Info_owner_init_data_init_mu;Mutexdef m_s_Info_owner_init_layouts_mu;Mutexdef m_s_Info_owner_init_layouts_init_mu;Mutexdef m_s_Info_owner_init_gitInfo_mu;Mutexdef m_s_Info_owner_init_gitInfo_init_mu;Mutexdef m_s_Info_owner_init_translations_mu;Mutexdef m_s_Info_owner_init_translations_init_mu;Mutexdef m_s_Info_language_paramsMu;Mutexdef m_s_language_paramsMu;Mutexdef m_s_relatedDocsHandler_mu;Mutexdef m_s_init_prevNext_mu;Mutexdef m_s_init_prevNext_init_mu;Mutexdef m_s_init_prevNextInSection_mu;Mutexdef m_s_init_prevNextInSection_init_mu;Mutexdef m_s_init_menus_mu;Mutexdef m_s_init_menus_init_mu;Mutexdef m_s_init_taxonomies_mu;Mutexdef m_s_init_taxonomies_init_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

