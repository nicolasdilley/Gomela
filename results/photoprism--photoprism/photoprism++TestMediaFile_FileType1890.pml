// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/photoprism/mediafile_test.go#L1890
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMediaFile_FileType18900 = [1] of {int};
	run TestMediaFile_FileType1890(child_TestMediaFile_FileType18900);
	run receiver(child_TestMediaFile_FileType18900)
stop_process:skip
}

proctype TestMediaFile_FileType1890(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Extension6233 = [1] of {int};
	chan child_FileType6732 = [1] of {int};
	chan child_FileType6731 = [1] of {int};
	chan child_IsJpeg6280 = [1] of {int};
	Mutexdef m_metaDataOnce_m;
	run mutexMonitor(m_metaDataOnce_m);
	run IsJpeg628(m_metaDataOnce_m,child_IsJpeg6280);
	child_IsJpeg6280?0;
	run FileType673(m_metaDataOnce_m,child_FileType6731);
	child_FileType6731?0;
	run FileType673(m_metaDataOnce_m,child_FileType6732);
	child_FileType6732?0;
	run Extension623(m_metaDataOnce_m,child_Extension6233);
	child_Extension6233?0;
	stop_process: skip;
	child!0
}
proctype IsJpeg628(Mutexdef m_metaDataOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MimeType5221 = [1] of {int};
	chan child_Extension6230 = [1] of {int};
	run Extension623(m_metaDataOnce_m,child_Extension6230);
	child_Extension6230?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run MimeType522(m_metaDataOnce_m,child_MimeType5221);
	child_MimeType5221?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Extension623(Mutexdef m_metaDataOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MimeType522(Mutexdef m_metaDataOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FileName3821 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run FileName382(m_metaDataOnce_m,child_FileName3821);
	child_FileName3821?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype FileName382(Mutexdef m_metaDataOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype FileType673(Mutexdef m_metaDataOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsBitmap6585 = [1] of {int};
	chan child_IsHEIF6534 = [1] of {int};
	chan child_IsGif6433 = [1] of {int};
	chan child_IsPng6382 = [1] of {int};
	chan child_IsJpeg6281 = [1] of {int};
	run IsJpeg628(m_metaDataOnce_m,child_IsJpeg6281);
	child_IsJpeg6281?0;
	run IsPng638(m_metaDataOnce_m,child_IsPng6382);
	child_IsPng6382?0;
	run IsGif643(m_metaDataOnce_m,child_IsGif6433);
	child_IsGif6433?0;
	run IsHEIF653(m_metaDataOnce_m,child_IsHEIF6534);
	child_IsHEIF6534?0;
	run IsBitmap658(m_metaDataOnce_m,child_IsBitmap6585);
	child_IsBitmap6585?0;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	stop_process: skip;
	child!0
}
proctype IsPng638(Mutexdef m_metaDataOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MimeType5222 = [1] of {int};
	run MimeType522(m_metaDataOnce_m,child_MimeType5222);
	child_MimeType5222?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype IsGif643(Mutexdef m_metaDataOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MimeType5223 = [1] of {int};
	run MimeType522(m_metaDataOnce_m,child_MimeType5223);
	child_MimeType5223?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype IsHEIF653(Mutexdef m_metaDataOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MimeType5224 = [1] of {int};
	run MimeType522(m_metaDataOnce_m,child_MimeType5224);
	child_MimeType5224?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype IsBitmap658(Mutexdef m_metaDataOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MimeType5225 = [1] of {int};
	run MimeType522(m_metaDataOnce_m,child_MimeType5225);
	child_MimeType5225?0;
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

proctype receiver(chan c) {
c?0
}

