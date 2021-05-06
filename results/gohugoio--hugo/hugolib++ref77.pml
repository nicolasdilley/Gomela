
// https://github.com/gohugoio/hugo/blob/master/hugolib/page__ref.go#L77
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ref770 = [1] of {int};
	run ref77(child_ref770)
stop_process:skip
}

proctype ref77(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_refLink8200 = [1] of {int};
	Mutexdef s_init_taxonomies_init_mu;
	Mutexdef s_init_taxonomies_mu;
	Mutexdef s_init_menus_init_mu;
	Mutexdef s_init_menus_mu;
	Mutexdef s_init_prevNextInSection_init_mu;
	Mutexdef s_init_prevNextInSection_mu;
	Mutexdef s_init_prevNext_init_mu;
	Mutexdef s_init_prevNext_mu;
	Mutexdef s_relatedDocsHandler_mu;
	Mutexdef s_language_paramsMu;
	Mutexdef s_Info_language_paramsMu;
	Mutexdef s_Info_owner_init_translations_init_mu;
	Mutexdef s_Info_owner_init_translations_mu;
	Mutexdef s_Info_owner_init_gitInfo_init_mu;
	Mutexdef s_Info_owner_init_gitInfo_mu;
	Mutexdef s_Info_owner_init_layouts_init_mu;
	Mutexdef s_Info_owner_init_layouts_mu;
	Mutexdef s_Info_owner_init_data_init_mu;
	Mutexdef s_Info_owner_init_data_mu;
	Mutexdef s_Info_owner_skipRebuildForFilenamesMu;
	Mutexdef s_Info_owner_ContentChanges_symContentMu;
	Mutexdef s_Info_owner_ContentChanges_mu;
	Mutexdef s_Info_owner_contentInit_m;
	Mutexdef s_Info_owner_runningMu;
	Mutexdef s_Info_owner_multilingual_langMapInit_m;
	Mutexdef s_Info_owner_multilingual_DefaultLang_paramsMu;
	Mutexdef s_h_init_translations_init_mu;
	Mutexdef s_h_init_translations_mu;
	Mutexdef s_h_init_gitInfo_init_mu;
	Mutexdef s_h_init_gitInfo_mu;
	Mutexdef s_h_init_layouts_init_mu;
	Mutexdef s_h_init_layouts_mu;
	Mutexdef s_h_init_data_init_mu;
	Mutexdef s_h_init_data_mu;
	Mutexdef s_h_skipRebuildForFilenamesMu;
	Mutexdef s_h_ContentChanges_symContentMu;
	Mutexdef s_h_ContentChanges_mu;
	Mutexdef s_h_contentInit_m;
	Mutexdef s_h_runningMu;
	Mutexdef s_h_multilingual_langMapInit_m;
	Mutexdef s_h_multilingual_DefaultLang_paramsMu;
	run mutexMonitor(s_h_multilingual_DefaultLang_paramsMu);
	run mutexMonitor(s_h_multilingual_langMapInit_m);
	run mutexMonitor(s_h_runningMu);
	run mutexMonitor(s_h_contentInit_m);
	run mutexMonitor(s_h_ContentChanges_mu);
	run mutexMonitor(s_h_ContentChanges_symContentMu);
	run mutexMonitor(s_h_skipRebuildForFilenamesMu);
	run mutexMonitor(s_h_init_data_mu);
	run mutexMonitor(s_h_init_data_init_mu);
	run mutexMonitor(s_h_init_layouts_mu);
	run mutexMonitor(s_h_init_layouts_init_mu);
	run mutexMonitor(s_h_init_gitInfo_mu);
	run mutexMonitor(s_h_init_gitInfo_init_mu);
	run mutexMonitor(s_h_init_translations_mu);
	run mutexMonitor(s_h_init_translations_init_mu);
	run mutexMonitor(s_Info_owner_multilingual_DefaultLang_paramsMu);
	run mutexMonitor(s_Info_owner_multilingual_langMapInit_m);
	run mutexMonitor(s_Info_owner_runningMu);
	run mutexMonitor(s_Info_owner_contentInit_m);
	run mutexMonitor(s_Info_owner_ContentChanges_mu);
	run mutexMonitor(s_Info_owner_ContentChanges_symContentMu);
	run mutexMonitor(s_Info_owner_skipRebuildForFilenamesMu);
	run mutexMonitor(s_Info_owner_init_data_mu);
	run mutexMonitor(s_Info_owner_init_data_init_mu);
	run mutexMonitor(s_Info_owner_init_layouts_mu);
	run mutexMonitor(s_Info_owner_init_layouts_init_mu);
	run mutexMonitor(s_Info_owner_init_gitInfo_mu);
	run mutexMonitor(s_Info_owner_init_gitInfo_init_mu);
	run mutexMonitor(s_Info_owner_init_translations_mu);
	run mutexMonitor(s_Info_owner_init_translations_init_mu);
	run mutexMonitor(s_Info_language_paramsMu);
	run mutexMonitor(s_language_paramsMu);
	run mutexMonitor(s_relatedDocsHandler_mu);
	run mutexMonitor(s_init_prevNext_mu);
	run mutexMonitor(s_init_prevNext_init_mu);
	run mutexMonitor(s_init_prevNextInSection_mu);
	run mutexMonitor(s_init_prevNextInSection_init_mu);
	run mutexMonitor(s_init_menus_mu);
	run mutexMonitor(s_init_menus_init_mu);
	run mutexMonitor(s_init_taxonomies_mu);
	run mutexMonitor(s_init_taxonomies_init_mu);
	

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
	run refLink820(s_h_multilingual_DefaultLang_paramsMu,s_h_multilingual_langMapInit_m,s_h_runningMu,s_h_contentInit_m,s_h_ContentChanges_mu,s_h_ContentChanges_symContentMu,s_h_skipRebuildForFilenamesMu,s_h_init_data_mu,s_h_init_data_init_mu,s_h_init_layouts_mu,s_h_init_layouts_init_mu,s_h_init_gitInfo_mu,s_h_init_gitInfo_init_mu,s_h_init_translations_mu,s_h_init_translations_init_mu,s_Info_owner_multilingual_DefaultLang_paramsMu,s_Info_owner_multilingual_langMapInit_m,s_Info_owner_runningMu,s_Info_owner_contentInit_m,s_Info_owner_ContentChanges_mu,s_Info_owner_ContentChanges_symContentMu,s_Info_owner_skipRebuildForFilenamesMu,s_Info_owner_init_data_mu,s_Info_owner_init_data_init_mu,s_Info_owner_init_layouts_mu,s_Info_owner_init_layouts_init_mu,s_Info_owner_init_gitInfo_mu,s_Info_owner_init_gitInfo_init_mu,s_Info_owner_init_translations_mu,s_Info_owner_init_translations_init_mu,s_Info_language_paramsMu,s_language_paramsMu,s_relatedDocsHandler_mu,s_init_prevNext_mu,s_init_prevNext_init_mu,s_init_prevNextInSection_mu,s_init_prevNextInSection_init_mu,s_init_menus_mu,s_init_menus_init_mu,s_init_taxonomies_mu,s_init_taxonomies_init_mu,child_refLink8200);
	child_refLink8200?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype refLink820(Mutexdef s_h_multilingual_DefaultLang_paramsMu;Mutexdef s_h_multilingual_langMapInit_m;Mutexdef s_h_runningMu;Mutexdef s_h_contentInit_m;Mutexdef s_h_ContentChanges_mu;Mutexdef s_h_ContentChanges_symContentMu;Mutexdef s_h_skipRebuildForFilenamesMu;Mutexdef s_h_init_data_mu;Mutexdef s_h_init_data_init_mu;Mutexdef s_h_init_layouts_mu;Mutexdef s_h_init_layouts_init_mu;Mutexdef s_h_init_gitInfo_mu;Mutexdef s_h_init_gitInfo_init_mu;Mutexdef s_h_init_translations_mu;Mutexdef s_h_init_translations_init_mu;Mutexdef s_Info_owner_multilingual_DefaultLang_paramsMu;Mutexdef s_Info_owner_multilingual_langMapInit_m;Mutexdef s_Info_owner_runningMu;Mutexdef s_Info_owner_contentInit_m;Mutexdef s_Info_owner_ContentChanges_mu;Mutexdef s_Info_owner_ContentChanges_symContentMu;Mutexdef s_Info_owner_skipRebuildForFilenamesMu;Mutexdef s_Info_owner_init_data_mu;Mutexdef s_Info_owner_init_data_init_mu;Mutexdef s_Info_owner_init_layouts_mu;Mutexdef s_Info_owner_init_layouts_init_mu;Mutexdef s_Info_owner_init_gitInfo_mu;Mutexdef s_Info_owner_init_gitInfo_init_mu;Mutexdef s_Info_owner_init_translations_mu;Mutexdef s_Info_owner_init_translations_init_mu;Mutexdef s_Info_language_paramsMu;Mutexdef s_language_paramsMu;Mutexdef s_relatedDocsHandler_mu;Mutexdef s_init_prevNext_mu;Mutexdef s_init_prevNext_init_mu;Mutexdef s_init_prevNextInSection_mu;Mutexdef s_init_prevNextInSection_init_mu;Mutexdef s_init_menus_mu;Mutexdef s_init_menus_init_mu;Mutexdef s_init_taxonomies_mu;Mutexdef s_init_taxonomies_init_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_logNotFound8102 = [1] of {int};
	chan child_logNotFound8101 = [1] of {int};
	chan child_logNotFound8100 = [1] of {int};
	

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
		

		if
		:: true -> 
			run logNotFound810(s_h_multilingual_DefaultLang_paramsMu,s_h_multilingual_langMapInit_m,s_h_runningMu,s_h_contentInit_m,s_h_ContentChanges_mu,s_h_ContentChanges_symContentMu,s_h_skipRebuildForFilenamesMu,s_h_init_data_mu,s_h_init_data_init_mu,s_h_init_layouts_mu,s_h_init_layouts_init_mu,s_h_init_gitInfo_mu,s_h_init_gitInfo_init_mu,s_h_init_translations_mu,s_h_init_translations_init_mu,s_Info_owner_multilingual_DefaultLang_paramsMu,s_Info_owner_multilingual_langMapInit_m,s_Info_owner_runningMu,s_Info_owner_contentInit_m,s_Info_owner_ContentChanges_mu,s_Info_owner_ContentChanges_symContentMu,s_Info_owner_skipRebuildForFilenamesMu,s_Info_owner_init_data_mu,s_Info_owner_init_data_init_mu,s_Info_owner_init_layouts_mu,s_Info_owner_init_layouts_init_mu,s_Info_owner_init_gitInfo_mu,s_Info_owner_init_gitInfo_init_mu,s_Info_owner_init_translations_mu,s_Info_owner_init_translations_init_mu,s_Info_language_paramsMu,s_language_paramsMu,s_relatedDocsHandler_mu,s_init_prevNext_mu,s_init_prevNext_init_mu,s_init_prevNextInSection_mu,s_init_prevNextInSection_init_mu,s_init_menus_mu,s_init_menus_init_mu,s_init_taxonomies_mu,s_init_taxonomies_init_mu,child_logNotFound8100);
			child_logNotFound8100?0;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			run logNotFound810(s_h_multilingual_DefaultLang_paramsMu,s_h_multilingual_langMapInit_m,s_h_runningMu,s_h_contentInit_m,s_h_ContentChanges_mu,s_h_ContentChanges_symContentMu,s_h_skipRebuildForFilenamesMu,s_h_init_data_mu,s_h_init_data_init_mu,s_h_init_layouts_mu,s_h_init_layouts_init_mu,s_h_init_gitInfo_mu,s_h_init_gitInfo_init_mu,s_h_init_translations_mu,s_h_init_translations_init_mu,s_Info_owner_multilingual_DefaultLang_paramsMu,s_Info_owner_multilingual_langMapInit_m,s_Info_owner_runningMu,s_Info_owner_contentInit_m,s_Info_owner_ContentChanges_mu,s_Info_owner_ContentChanges_symContentMu,s_Info_owner_skipRebuildForFilenamesMu,s_Info_owner_init_data_mu,s_Info_owner_init_data_init_mu,s_Info_owner_init_layouts_mu,s_Info_owner_init_layouts_init_mu,s_Info_owner_init_gitInfo_mu,s_Info_owner_init_gitInfo_init_mu,s_Info_owner_init_translations_mu,s_Info_owner_init_translations_init_mu,s_Info_language_paramsMu,s_language_paramsMu,s_relatedDocsHandler_mu,s_init_prevNext_mu,s_init_prevNext_init_mu,s_init_prevNextInSection_mu,s_init_prevNextInSection_init_mu,s_init_menus_mu,s_init_menus_init_mu,s_init_taxonomies_mu,s_init_taxonomies_init_mu,child_logNotFound8101);
			child_logNotFound8101?0;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				run logNotFound810(s_h_multilingual_DefaultLang_paramsMu,s_h_multilingual_langMapInit_m,s_h_runningMu,s_h_contentInit_m,s_h_ContentChanges_mu,s_h_ContentChanges_symContentMu,s_h_skipRebuildForFilenamesMu,s_h_init_data_mu,s_h_init_data_init_mu,s_h_init_layouts_mu,s_h_init_layouts_init_mu,s_h_init_gitInfo_mu,s_h_init_gitInfo_init_mu,s_h_init_translations_mu,s_h_init_translations_init_mu,s_Info_owner_multilingual_DefaultLang_paramsMu,s_Info_owner_multilingual_langMapInit_m,s_Info_owner_runningMu,s_Info_owner_contentInit_m,s_Info_owner_ContentChanges_mu,s_Info_owner_ContentChanges_symContentMu,s_Info_owner_skipRebuildForFilenamesMu,s_Info_owner_init_data_mu,s_Info_owner_init_data_init_mu,s_Info_owner_init_layouts_mu,s_Info_owner_init_layouts_init_mu,s_Info_owner_init_gitInfo_mu,s_Info_owner_init_gitInfo_init_mu,s_Info_owner_init_translations_mu,s_Info_owner_init_translations_init_mu,s_Info_language_paramsMu,s_language_paramsMu,s_relatedDocsHandler_mu,s_init_prevNext_mu,s_init_prevNext_init_mu,s_init_prevNextInSection_mu,s_init_prevNextInSection_init_mu,s_init_menus_mu,s_init_menus_init_mu,s_init_taxonomies_mu,s_init_taxonomies_init_mu,child_logNotFound8102);
				child_logNotFound8102?0;
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype logNotFound810(Mutexdef s_h_multilingual_DefaultLang_paramsMu;Mutexdef s_h_multilingual_langMapInit_m;Mutexdef s_h_runningMu;Mutexdef s_h_contentInit_m;Mutexdef s_h_ContentChanges_mu;Mutexdef s_h_ContentChanges_symContentMu;Mutexdef s_h_skipRebuildForFilenamesMu;Mutexdef s_h_init_data_mu;Mutexdef s_h_init_data_init_mu;Mutexdef s_h_init_layouts_mu;Mutexdef s_h_init_layouts_init_mu;Mutexdef s_h_init_gitInfo_mu;Mutexdef s_h_init_gitInfo_init_mu;Mutexdef s_h_init_translations_mu;Mutexdef s_h_init_translations_init_mu;Mutexdef s_Info_owner_multilingual_DefaultLang_paramsMu;Mutexdef s_Info_owner_multilingual_langMapInit_m;Mutexdef s_Info_owner_runningMu;Mutexdef s_Info_owner_contentInit_m;Mutexdef s_Info_owner_ContentChanges_mu;Mutexdef s_Info_owner_ContentChanges_symContentMu;Mutexdef s_Info_owner_skipRebuildForFilenamesMu;Mutexdef s_Info_owner_init_data_mu;Mutexdef s_Info_owner_init_data_init_mu;Mutexdef s_Info_owner_init_layouts_mu;Mutexdef s_Info_owner_init_layouts_init_mu;Mutexdef s_Info_owner_init_gitInfo_mu;Mutexdef s_Info_owner_init_gitInfo_init_mu;Mutexdef s_Info_owner_init_translations_mu;Mutexdef s_Info_owner_init_translations_init_mu;Mutexdef s_Info_language_paramsMu;Mutexdef s_language_paramsMu;Mutexdef s_relatedDocsHandler_mu;Mutexdef s_init_prevNext_mu;Mutexdef s_init_prevNext_init_mu;Mutexdef s_init_prevNextInSection_mu;Mutexdef s_init_prevNextInSection_init_mu;Mutexdef s_init_menus_mu;Mutexdef s_init_menus_init_mu;Mutexdef s_init_taxonomies_mu;Mutexdef s_init_taxonomies_init_mu;chan child) {
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

