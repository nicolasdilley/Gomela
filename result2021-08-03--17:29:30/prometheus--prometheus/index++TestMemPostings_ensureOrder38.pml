// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/prometheus/prometheus/blob/27b78c336e436e9eed8b55ab0b162b888ec641d8/tsdb/index/postings_test.go#L38
#define def_var_n202  ?? // mand n line 202
typedef Chandef {
	chan sync = [0] of {bool};
	chan enq = [0] of {int};
	chan deq = [0] of {bool,int};
	chan sending = [0] of {bool};
	chan rcving = [0] of {bool};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
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
	chan child_TestMemPostings_ensureOrder380 = [1] of {int};
	run TestMemPostings_ensureOrder38(child_TestMemPostings_ensureOrder380);
	run receiver(child_TestMemPostings_ensureOrder380)
stop_process:skip
}

proctype TestMemPostings_ensureOrder38(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_EnsureOrder1900 = [1] of {int};
	Mutexdef p_mtx;
	int var_e = -2; // opt var_e
	int var_p_m = -2; // opt var_p_m
	int var_l = -2; // opt var_l
	run mutexMonitor(p_mtx);
	run EnsureOrder190(p_mtx,child_EnsureOrder1900);
	child_EnsureOrder1900?0;
	stop_process: skip;
	child!0
}
proctype EnsureOrder190(Mutexdef p_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousEnsureOrder2051990 = [1] of {int};
	Wgdef wg;
	Chandef workc_ch;
	int var_e = -2; // opt var_e
	int var_p_m = -2; // opt var_p_m
	int var_n = def_var_n202; // mand var_n
	p_mtx.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run sync_monitor(workc_ch);
	run wgMonitor(wg);
	wg.update!var_n;
		for(i : 0.. var_n-1) {
		for20: skip;
		run AnonymousEnsureOrder205199(workc_ch,wg,p_mtx,child_AnonymousEnsureOrder2051990);
		run receiver(child_AnonymousEnsureOrder2051990);
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: var_p_m-1 != -3 -> 
				for(i : 0.. var_p_m-1) {
			for30: skip;
			

			if
			:: var_e-1 != -3 -> 
								for(i : 0.. var_e-1) {
					for31: skip;
					

					if
					:: workc_ch.enq!0;
					:: workc_ch.sync!false -> 
						workc_ch.sending!false
					fi;
					for31_end: skip
				};
				for31_exit: skip
			:: else -> 
				do
				:: true -> 
					for32: skip;
					

					if
					:: workc_ch.enq!0;
					:: workc_ch.sync!false -> 
						workc_ch.sending!false
					fi;
					for32_end: skip
				:: true -> 
					break
				od;
				for32_exit: skip
			fi;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for33: skip;
			

			if
			:: var_e-1 != -3 -> 
								for(i : 0.. var_e-1) {
					for34: skip;
					

					if
					:: workc_ch.enq!0;
					:: workc_ch.sync!false -> 
						workc_ch.sending!false
					fi;
					for34_end: skip
				};
				for34_exit: skip
			:: else -> 
				do
				:: true -> 
					for35: skip;
					

					if
					:: workc_ch.enq!0;
					:: workc_ch.sync!false -> 
						workc_ch.sending!false
					fi;
					for35_end: skip
				:: true -> 
					break
				od;
				for35_exit: skip
			fi;
			for33_end: skip
		:: true -> 
			break
		od;
		for33_exit: skip
	fi;
	workc_ch.closing!true;
	wg.wait?0;
		defer1: skip;
	p_mtx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousEnsureOrder205199(Chandef workc_ch;Wgdef wg;Mutexdef p_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		num_msgs = 0;
		

		if
		:: workc_ch.deq?state,num_msgs;
		:: workc_ch.sync?state -> 
			workc_ch.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for21: skip;
			for21_end: skip
		fi
	od;
	for21_exit: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.num_msgs > 0 -> // cannot send on closed channel
    end4: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.deq!true,ch.num_msgs -> 
  		 ch.num_msgs = ch.num_msgs - 1
    fi;
  :: else ->    end5: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.sync!true; 
    fi;
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.deq!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		    ch.closed = true
		   :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.enq?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.rcving?false ->
 		    ch.sending?false;
		fi;
		:: else -> 
		end3: if
		  :: ch.enq?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.deq!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		     ch.closed = true
		  :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.rcving?false;
  :: ch.sync!true; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.rcving?false ->
       ch.sending?false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

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

proctype receiver(chan c) {
c?0
}

