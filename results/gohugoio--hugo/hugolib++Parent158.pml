
// https://github.com/gohugoio/hugo/blob/master/hugolib/page__tree.go#L158
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Parent1580 = [1] of {int};
	run Parent158(child_Parent1580)
stop_process:skip
}

proctype Parent158(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getSection9630 = [1] of {int};
	Mutexdef tree_m_s_init_taxonomies_init_mu;
	Mutexdef tree_m_s_init_taxonomies_mu;
	Mutexdef tree_m_s_init_menus_init_mu;
	Mutexdef tree_m_s_init_menus_mu;
	Mutexdef tree_m_s_init_prevNextInSection_init_mu;
	Mutexdef tree_m_s_init_prevNextInSection_mu;
	Mutexdef tree_m_s_init_prevNext_init_mu;
	Mutexdef tree_m_s_init_prevNext_mu;
	Mutexdef tree_m_s_relatedDocsHandler_mu;
	Mutexdef tree_m_s_language_paramsMu;
	Mutexdef tree_m_s_Info_language_paramsMu;
	Mutexdef tree_m_s_Info_owner_init_translations_init_mu;
	Mutexdef tree_m_s_Info_owner_init_translations_mu;
	Mutexdef tree_m_s_Info_owner_init_gitInfo_init_mu;
	Mutexdef tree_m_s_Info_owner_init_gitInfo_mu;
	Mutexdef tree_m_s_Info_owner_init_layouts_init_mu;
	Mutexdef tree_m_s_Info_owner_init_layouts_mu;
	Mutexdef tree_m_s_Info_owner_init_data_init_mu;
	Mutexdef tree_m_s_Info_owner_init_data_mu;
	Mutexdef tree_m_s_Info_owner_skipRebuildForFilenamesMu;
	Mutexdef tree_m_s_Info_owner_ContentChanges_symContentMu;
	Mutexdef tree_m_s_Info_owner_ContentChanges_mu;
	Mutexdef tree_m_s_Info_owner_contentInit_m;
	Mutexdef tree_m_s_Info_owner_runningMu;
	Mutexdef tree_m_s_Info_owner_multilingual_langMapInit_m;
	Mutexdef tree_m_s_Info_owner_multilingual_DefaultLang_paramsMu;
	Mutexdef tree_m_s_h_init_translations_init_mu;
	Mutexdef tree_m_s_h_init_translations_mu;
	Mutexdef tree_m_s_h_init_gitInfo_init_mu;
	Mutexdef tree_m_s_h_init_gitInfo_mu;
	Mutexdef tree_m_s_h_init_layouts_init_mu;
	Mutexdef tree_m_s_h_init_layouts_mu;
	Mutexdef tree_m_s_h_init_data_init_mu;
	Mutexdef tree_m_s_h_init_data_mu;
	Mutexdef tree_m_s_h_skipRebuildForFilenamesMu;
	Mutexdef tree_m_s_h_ContentChanges_symContentMu;
	Mutexdef tree_m_s_h_ContentChanges_mu;
	Mutexdef tree_m_s_h_contentInit_m;
	Mutexdef tree_m_s_h_runningMu;
	Mutexdef tree_m_s_h_multilingual_langMapInit_m;
	Mutexdef tree_m_s_h_multilingual_DefaultLang_paramsMu;
	

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
	run mutexMonitor(tree_m_s_h_multilingual_DefaultLang_paramsMu);
	run mutexMonitor(tree_m_s_h_multilingual_langMapInit_m);
	run mutexMonitor(tree_m_s_h_runningMu);
	run mutexMonitor(tree_m_s_h_contentInit_m);
	run mutexMonitor(tree_m_s_h_ContentChanges_mu);
	run mutexMonitor(tree_m_s_h_ContentChanges_symContentMu);
	run mutexMonitor(tree_m_s_h_skipRebuildForFilenamesMu);
	run mutexMonitor(tree_m_s_h_init_data_mu);
	run mutexMonitor(tree_m_s_h_init_data_init_mu);
	run mutexMonitor(tree_m_s_h_init_layouts_mu);
	run mutexMonitor(tree_m_s_h_init_layouts_init_mu);
	run mutexMonitor(tree_m_s_h_init_gitInfo_mu);
	run mutexMonitor(tree_m_s_h_init_gitInfo_init_mu);
	run mutexMonitor(tree_m_s_h_init_translations_mu);
	run mutexMonitor(tree_m_s_h_init_translations_init_mu);
	run mutexMonitor(tree_m_s_Info_owner_multilingual_DefaultLang_paramsMu);
	run mutexMonitor(tree_m_s_Info_owner_multilingual_langMapInit_m);
	run mutexMonitor(tree_m_s_Info_owner_runningMu);
	run mutexMonitor(tree_m_s_Info_owner_contentInit_m);
	run mutexMonitor(tree_m_s_Info_owner_ContentChanges_mu);
	run mutexMonitor(tree_m_s_Info_owner_ContentChanges_symContentMu);
	run mutexMonitor(tree_m_s_Info_owner_skipRebuildForFilenamesMu);
	run mutexMonitor(tree_m_s_Info_owner_init_data_mu);
	run mutexMonitor(tree_m_s_Info_owner_init_data_init_mu);
	run mutexMonitor(tree_m_s_Info_owner_init_layouts_mu);
	run mutexMonitor(tree_m_s_Info_owner_init_layouts_init_mu);
	run mutexMonitor(tree_m_s_Info_owner_init_gitInfo_mu);
	run mutexMonitor(tree_m_s_Info_owner_init_gitInfo_init_mu);
	run mutexMonitor(tree_m_s_Info_owner_init_translations_mu);
	run mutexMonitor(tree_m_s_Info_owner_init_translations_init_mu);
	run mutexMonitor(tree_m_s_Info_language_paramsMu);
	run mutexMonitor(tree_m_s_language_paramsMu);
	run mutexMonitor(tree_m_s_relatedDocsHandler_mu);
	run mutexMonitor(tree_m_s_init_prevNext_mu);
	run mutexMonitor(tree_m_s_init_prevNext_init_mu);
	run mutexMonitor(tree_m_s_init_prevNextInSection_mu);
	run mutexMonitor(tree_m_s_init_prevNextInSection_init_mu);
	run mutexMonitor(tree_m_s_init_menus_mu);
	run mutexMonitor(tree_m_s_init_menus_init_mu);
	run mutexMonitor(tree_m_s_init_taxonomies_mu);
	run mutexMonitor(tree_m_s_init_taxonomies_init_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getSection963(tree_m_s_h_multilingual_DefaultLang_paramsMu,tree_m_s_h_multilingual_langMapInit_m,tree_m_s_h_runningMu,tree_m_s_h_contentInit_m,tree_m_s_h_ContentChanges_mu,tree_m_s_h_ContentChanges_symContentMu,tree_m_s_h_skipRebuildForFilenamesMu,tree_m_s_h_init_data_mu,tree_m_s_h_init_data_init_mu,tree_m_s_h_init_layouts_mu,tree_m_s_h_init_layouts_init_mu,tree_m_s_h_init_gitInfo_mu,tree_m_s_h_init_gitInfo_init_mu,tree_m_s_h_init_translations_mu,tree_m_s_h_init_translations_init_mu,tree_m_s_Info_owner_multilingual_DefaultLang_paramsMu,tree_m_s_Info_owner_multilingual_langMapInit_m,tree_m_s_Info_owner_runningMu,tree_m_s_Info_owner_contentInit_m,tree_m_s_Info_owner_ContentChanges_mu,tree_m_s_Info_owner_ContentChanges_symContentMu,tree_m_s_Info_owner_skipRebuildForFilenamesMu,tree_m_s_Info_owner_init_data_mu,tree_m_s_Info_owner_init_data_init_mu,tree_m_s_Info_owner_init_layouts_mu,tree_m_s_Info_owner_init_layouts_init_mu,tree_m_s_Info_owner_init_gitInfo_mu,tree_m_s_Info_owner_init_gitInfo_init_mu,tree_m_s_Info_owner_init_translations_mu,tree_m_s_Info_owner_init_translations_init_mu,tree_m_s_Info_language_paramsMu,tree_m_s_language_paramsMu,tree_m_s_relatedDocsHandler_mu,tree_m_s_init_prevNext_mu,tree_m_s_init_prevNext_init_mu,tree_m_s_init_prevNextInSection_mu,tree_m_s_init_prevNextInSection_init_mu,tree_m_s_init_menus_mu,tree_m_s_init_menus_init_mu,tree_m_s_init_taxonomies_mu,tree_m_s_init_taxonomies_init_mu,child_getSection9630);
	child_getSection9630?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getSection963(Mutexdef c_m_s_h_multilingual_DefaultLang_paramsMu;Mutexdef c_m_s_h_multilingual_langMapInit_m;Mutexdef c_m_s_h_runningMu;Mutexdef c_m_s_h_contentInit_m;Mutexdef c_m_s_h_ContentChanges_mu;Mutexdef c_m_s_h_ContentChanges_symContentMu;Mutexdef c_m_s_h_skipRebuildForFilenamesMu;Mutexdef c_m_s_h_init_data_mu;Mutexdef c_m_s_h_init_data_init_mu;Mutexdef c_m_s_h_init_layouts_mu;Mutexdef c_m_s_h_init_layouts_init_mu;Mutexdef c_m_s_h_init_gitInfo_mu;Mutexdef c_m_s_h_init_gitInfo_init_mu;Mutexdef c_m_s_h_init_translations_mu;Mutexdef c_m_s_h_init_translations_init_mu;Mutexdef c_m_s_Info_owner_multilingual_DefaultLang_paramsMu;Mutexdef c_m_s_Info_owner_multilingual_langMapInit_m;Mutexdef c_m_s_Info_owner_runningMu;Mutexdef c_m_s_Info_owner_contentInit_m;Mutexdef c_m_s_Info_owner_ContentChanges_mu;Mutexdef c_m_s_Info_owner_ContentChanges_symContentMu;Mutexdef c_m_s_Info_owner_skipRebuildForFilenamesMu;Mutexdef c_m_s_Info_owner_init_data_mu;Mutexdef c_m_s_Info_owner_init_data_init_mu;Mutexdef c_m_s_Info_owner_init_layouts_mu;Mutexdef c_m_s_Info_owner_init_layouts_init_mu;Mutexdef c_m_s_Info_owner_init_gitInfo_mu;Mutexdef c_m_s_Info_owner_init_gitInfo_init_mu;Mutexdef c_m_s_Info_owner_init_translations_mu;Mutexdef c_m_s_Info_owner_init_translations_init_mu;Mutexdef c_m_s_Info_language_paramsMu;Mutexdef c_m_s_language_paramsMu;Mutexdef c_m_s_relatedDocsHandler_mu;Mutexdef c_m_s_init_prevNext_mu;Mutexdef c_m_s_init_prevNext_init_mu;Mutexdef c_m_s_init_prevNextInSection_mu;Mutexdef c_m_s_init_prevNextInSection_init_mu;Mutexdef c_m_s_init_menus_mu;Mutexdef c_m_s_init_menus_init_mu;Mutexdef c_m_s_init_taxonomies_mu;Mutexdef c_m_s_init_taxonomies_init_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getSection5431 = [1] of {int};
	chan child_getTaxonomyParent5540 = [1] of {int};
	

	if
	:: true -> 
		run getTaxonomyParent554(c_m_s_h_multilingual_DefaultLang_paramsMu,c_m_s_h_multilingual_langMapInit_m,c_m_s_h_runningMu,c_m_s_h_contentInit_m,c_m_s_h_ContentChanges_mu,c_m_s_h_ContentChanges_symContentMu,c_m_s_h_skipRebuildForFilenamesMu,c_m_s_h_init_data_mu,c_m_s_h_init_data_init_mu,c_m_s_h_init_layouts_mu,c_m_s_h_init_layouts_init_mu,c_m_s_h_init_gitInfo_mu,c_m_s_h_init_gitInfo_init_mu,c_m_s_h_init_translations_mu,c_m_s_h_init_translations_init_mu,c_m_s_Info_owner_multilingual_DefaultLang_paramsMu,c_m_s_Info_owner_multilingual_langMapInit_m,c_m_s_Info_owner_runningMu,c_m_s_Info_owner_contentInit_m,c_m_s_Info_owner_ContentChanges_mu,c_m_s_Info_owner_ContentChanges_symContentMu,c_m_s_Info_owner_skipRebuildForFilenamesMu,c_m_s_Info_owner_init_data_mu,c_m_s_Info_owner_init_data_init_mu,c_m_s_Info_owner_init_layouts_mu,c_m_s_Info_owner_init_layouts_init_mu,c_m_s_Info_owner_init_gitInfo_mu,c_m_s_Info_owner_init_gitInfo_init_mu,c_m_s_Info_owner_init_translations_mu,c_m_s_Info_owner_init_translations_init_mu,c_m_s_Info_language_paramsMu,c_m_s_language_paramsMu,c_m_s_relatedDocsHandler_mu,c_m_s_init_prevNext_mu,c_m_s_init_prevNext_init_mu,c_m_s_init_prevNextInSection_mu,c_m_s_init_prevNextInSection_init_mu,c_m_s_init_menus_mu,c_m_s_init_menus_init_mu,c_m_s_init_taxonomies_mu,c_m_s_init_taxonomies_init_mu,child_getTaxonomyParent5540);
		child_getTaxonomyParent5540?0;
		goto stop_process
	:: true;
	fi;
	run getSection543(c_m_s_h_multilingual_DefaultLang_paramsMu,c_m_s_h_multilingual_langMapInit_m,c_m_s_h_runningMu,c_m_s_h_contentInit_m,c_m_s_h_ContentChanges_mu,c_m_s_h_ContentChanges_symContentMu,c_m_s_h_skipRebuildForFilenamesMu,c_m_s_h_init_data_mu,c_m_s_h_init_data_init_mu,c_m_s_h_init_layouts_mu,c_m_s_h_init_layouts_init_mu,c_m_s_h_init_gitInfo_mu,c_m_s_h_init_gitInfo_init_mu,c_m_s_h_init_translations_mu,c_m_s_h_init_translations_init_mu,c_m_s_Info_owner_multilingual_DefaultLang_paramsMu,c_m_s_Info_owner_multilingual_langMapInit_m,c_m_s_Info_owner_runningMu,c_m_s_Info_owner_contentInit_m,c_m_s_Info_owner_ContentChanges_mu,c_m_s_Info_owner_ContentChanges_symContentMu,c_m_s_Info_owner_skipRebuildForFilenamesMu,c_m_s_Info_owner_init_data_mu,c_m_s_Info_owner_init_data_init_mu,c_m_s_Info_owner_init_layouts_mu,c_m_s_Info_owner_init_layouts_init_mu,c_m_s_Info_owner_init_gitInfo_mu,c_m_s_Info_owner_init_gitInfo_init_mu,c_m_s_Info_owner_init_translations_mu,c_m_s_Info_owner_init_translations_init_mu,c_m_s_Info_language_paramsMu,c_m_s_language_paramsMu,c_m_s_relatedDocsHandler_mu,c_m_s_init_prevNext_mu,c_m_s_init_prevNext_init_mu,c_m_s_init_prevNextInSection_mu,c_m_s_init_prevNextInSection_init_mu,c_m_s_init_menus_mu,c_m_s_init_menus_init_mu,c_m_s_init_taxonomies_mu,c_m_s_init_taxonomies_init_mu,child_getSection5431);
	child_getSection5431?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getTaxonomyParent554(Mutexdef m_s_h_multilingual_DefaultLang_paramsMu;Mutexdef m_s_h_multilingual_langMapInit_m;Mutexdef m_s_h_runningMu;Mutexdef m_s_h_contentInit_m;Mutexdef m_s_h_ContentChanges_mu;Mutexdef m_s_h_ContentChanges_symContentMu;Mutexdef m_s_h_skipRebuildForFilenamesMu;Mutexdef m_s_h_init_data_mu;Mutexdef m_s_h_init_data_init_mu;Mutexdef m_s_h_init_layouts_mu;Mutexdef m_s_h_init_layouts_init_mu;Mutexdef m_s_h_init_gitInfo_mu;Mutexdef m_s_h_init_gitInfo_init_mu;Mutexdef m_s_h_init_translations_mu;Mutexdef m_s_h_init_translations_init_mu;Mutexdef m_s_Info_owner_multilingual_DefaultLang_paramsMu;Mutexdef m_s_Info_owner_multilingual_langMapInit_m;Mutexdef m_s_Info_owner_runningMu;Mutexdef m_s_Info_owner_contentInit_m;Mutexdef m_s_Info_owner_ContentChanges_mu;Mutexdef m_s_Info_owner_ContentChanges_symContentMu;Mutexdef m_s_Info_owner_skipRebuildForFilenamesMu;Mutexdef m_s_Info_owner_init_data_mu;Mutexdef m_s_Info_owner_init_data_init_mu;Mutexdef m_s_Info_owner_init_layouts_mu;Mutexdef m_s_Info_owner_init_layouts_init_mu;Mutexdef m_s_Info_owner_init_gitInfo_mu;Mutexdef m_s_Info_owner_init_gitInfo_init_mu;Mutexdef m_s_Info_owner_init_translations_mu;Mutexdef m_s_Info_owner_init_translations_init_mu;Mutexdef m_s_Info_language_paramsMu;Mutexdef m_s_language_paramsMu;Mutexdef m_s_relatedDocsHandler_mu;Mutexdef m_s_init_prevNext_mu;Mutexdef m_s_init_prevNext_init_mu;Mutexdef m_s_init_prevNextInSection_mu;Mutexdef m_s_init_prevNextInSection_init_mu;Mutexdef m_s_init_menus_mu;Mutexdef m_s_init_menus_init_mu;Mutexdef m_s_init_taxonomies_mu;Mutexdef m_s_init_taxonomies_init_mu;chan child) {
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
proctype getSection543(Mutexdef m_s_h_multilingual_DefaultLang_paramsMu;Mutexdef m_s_h_multilingual_langMapInit_m;Mutexdef m_s_h_runningMu;Mutexdef m_s_h_contentInit_m;Mutexdef m_s_h_ContentChanges_mu;Mutexdef m_s_h_ContentChanges_symContentMu;Mutexdef m_s_h_skipRebuildForFilenamesMu;Mutexdef m_s_h_init_data_mu;Mutexdef m_s_h_init_data_init_mu;Mutexdef m_s_h_init_layouts_mu;Mutexdef m_s_h_init_layouts_init_mu;Mutexdef m_s_h_init_gitInfo_mu;Mutexdef m_s_h_init_gitInfo_init_mu;Mutexdef m_s_h_init_translations_mu;Mutexdef m_s_h_init_translations_init_mu;Mutexdef m_s_Info_owner_multilingual_DefaultLang_paramsMu;Mutexdef m_s_Info_owner_multilingual_langMapInit_m;Mutexdef m_s_Info_owner_runningMu;Mutexdef m_s_Info_owner_contentInit_m;Mutexdef m_s_Info_owner_ContentChanges_mu;Mutexdef m_s_Info_owner_ContentChanges_symContentMu;Mutexdef m_s_Info_owner_skipRebuildForFilenamesMu;Mutexdef m_s_Info_owner_init_data_mu;Mutexdef m_s_Info_owner_init_data_init_mu;Mutexdef m_s_Info_owner_init_layouts_mu;Mutexdef m_s_Info_owner_init_layouts_init_mu;Mutexdef m_s_Info_owner_init_gitInfo_mu;Mutexdef m_s_Info_owner_init_gitInfo_init_mu;Mutexdef m_s_Info_owner_init_translations_mu;Mutexdef m_s_Info_owner_init_translations_init_mu;Mutexdef m_s_Info_language_paramsMu;Mutexdef m_s_language_paramsMu;Mutexdef m_s_relatedDocsHandler_mu;Mutexdef m_s_init_prevNext_mu;Mutexdef m_s_init_prevNext_init_mu;Mutexdef m_s_init_prevNextInSection_mu;Mutexdef m_s_init_prevNextInSection_init_mu;Mutexdef m_s_init_menus_mu;Mutexdef m_s_init_menus_init_mu;Mutexdef m_s_init_taxonomies_mu;Mutexdef m_s_init_taxonomies_init_mu;chan child) {
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

