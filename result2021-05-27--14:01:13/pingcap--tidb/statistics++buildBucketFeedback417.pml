// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/statistics/feedback.go#L417
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_buildBucketFeedback4170 = [1] of {int};
	run buildBucketFeedback417(child_buildBucketFeedback4170);
	run receiver(child_buildBucketFeedback4170)
stop_process:skip
}

proctype buildBucketFeedback417(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_adjustFeedbackBoundaries3920 = [1] of {int};
	chan child_adjustFeedbackBoundaries3921 = [1] of {int};
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_mu;
	int feedback_Feedback = -2; // opt feedback_Feedback
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(sc_mu);
	run mutexMonitor(sc_RuntimeStatsColl_mu);
	

	if
	:: feedback_Feedback-1 != -3 -> 
				for(i : 0.. feedback_Feedback-1) {
			for10: skip;
			run adjustFeedbackBoundaries392(sc_mu,sc_RuntimeStatsColl_mu,child_adjustFeedbackBoundaries3920);
			child_adjustFeedbackBoundaries3920?0;
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto for10_end
					:: true;
					fi
				fi
			fi;
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run adjustFeedbackBoundaries392(sc_mu,sc_RuntimeStatsColl_mu,child_adjustFeedbackBoundaries3921);
			child_adjustFeedbackBoundaries3921?0;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto for11_end
					:: true;
					fi
				fi
			fi;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype adjustFeedbackBoundaries392(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_outOfRange3721 = [1] of {int};
	chan child_outOfRange3720 = [1] of {int};
	run outOfRange372(sc_mu,sc_RuntimeStatsColl_mu,child_outOfRange3720);
	child_outOfRange3720?0;
	

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
	run outOfRange372(sc_mu,sc_RuntimeStatsColl_mu,child_outOfRange3721);
	child_outOfRange3721?0;
	

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

