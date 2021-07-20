// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/statistics/feedback.go#L526
#define not_found_598  -2 // opt fbs line 328
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_splitBucket5260 = [1] of {int};
	run splitBucket526(child_splitBucket5260);
	run receiver(child_splitBucket5260)
stop_process:skip
}

proctype splitBucket526(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_refineBucketCount6171 = [1] of {int};
	chan child_refineBucketCount6170 = [1] of {int};
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_mu;
	int var_boundsbounds = -2; // opt var_boundsbounds
	run mutexMonitor(sc_mu);
	run mutexMonitor(sc_RuntimeStatsColl_mu);
	

	if
	:: 0 != -2 && var_bounds-1 != -3 -> 
				for(i : 0.. var_bounds-1) {
			for19: skip;
			run refineBucketCount617(sc_mu,sc_RuntimeStatsColl_mu,child_refineBucketCount6171);
			child_refineBucketCount6171?0;
			

			if
			:: true -> 
				goto for19_end
			:: true;
			fi;
			for19_end: skip
		};
		for19_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run refineBucketCount617(sc_mu,sc_RuntimeStatsColl_mu,child_refineBucketCount6170);
			child_refineBucketCount6170?0;
			

			if
			:: true -> 
				goto for18_end
			:: true;
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype refineBucketCount617(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_mergeFullyContainedFeedback5810 = [1] of {int};
	int var_b_feedbackb_feedback = -2; // opt var_b_feedbackb_feedback
	run mergeFullyContainedFeedback581(sc_mu,sc_RuntimeStatsColl_mu,child_mergeFullyContainedFeedback5810);
	child_mergeFullyContainedFeedback5810?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype mergeFullyContainedFeedback581(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NonOverlappedFeedbacks3284 = [1] of {int};
	chan child_outOfRange3721 = [1] of {int};
	chan child_outOfRange3720 = [1] of {int};
	chan child_outOfRange3723 = [1] of {int};
	chan child_outOfRange3722 = [1] of {int};
	int var_sortedFBssortedFBs = -2; // opt var_sortedFBssortedFBs
	int var_b_feedbackb_feedback = -2; // opt var_b_feedbackb_feedback
	

	if
	:: var_b_feedback-1 != -3 -> 
				for(i : 0.. var_b_feedback-1) {
			for11: skip;
			run outOfRange372(sc_mu,sc_RuntimeStatsColl_mu,child_outOfRange3720);
			child_outOfRange3720?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run outOfRange372(sc_mu,sc_RuntimeStatsColl_mu,child_outOfRange3721);
			child_outOfRange3721?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for12: skip;
			run outOfRange372(sc_mu,sc_RuntimeStatsColl_mu,child_outOfRange3722);
			child_outOfRange3722?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run outOfRange372(sc_mu,sc_RuntimeStatsColl_mu,child_outOfRange3723);
			child_outOfRange3723?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for12_end: skip
		:: true -> 
			break
		od;
		for12_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run NonOverlappedFeedbacks328(sc_mu,sc_RuntimeStatsColl_mu,not_found_598,child_NonOverlappedFeedbacks3284);
	child_NonOverlappedFeedbacks3284?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype outOfRange372(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
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
proctype NonOverlappedFeedbacks328(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;int fbs;chan child) {
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

proctype receiver(chan c) {
c?0
}

