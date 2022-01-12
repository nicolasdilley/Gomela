// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob//fs/march/march.go#L128
#define def_var_checkers150  ?? // mand checkers line 150
#define def_var_jobs174  ?? // mand jobs line 174
#define ub_for155_4  ??
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
	chan child_Run1280 = [1] of {int};
	run Run128(child_Run1280);
	run receiver(child_Run1280)
stop_process:skip
}

proctype Run128(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousRun2031502 = [1] of {int};
	chan child_AnonymousRun1531500 = [1] of {int};
	Chandef in_ch;
	Wgdef traversing;
	Wgdef wg;
	Mutexdef mu;
	int var_checkers = def_var_checkers150; // mand var_checkers
	run mutexMonitor(mu);
	run wgMonitor(wg);
	run wgMonitor(traversing);
	

	if
	:: var_checkers > 0 -> 
		in_ch.size = var_checkers;
		run AsyncChan(in_ch)
	:: else -> 
		run sync_monitor(in_ch)
	fi;
		for(i : 0.. var_checkers-1) {
		for10: skip;
		wg.update!1;
		run AnonymousRun153150(in_ch,wg,traversing,mu,child_AnonymousRun1531500);
		run receiver(child_AnonymousRun1531500);
		for10_end: skip
	};
	for10_exit: skip;
	traversing.update!1;
	

	if
	:: in_ch.enq!0;
	:: in_ch.sync!false -> 
		in_ch.sending!false
	fi;
	run AnonymousRun203150(in_ch,wg,traversing,mu,child_AnonymousRun2031502);
	run receiver(child_AnonymousRun2031502);
	traversing.wait?0;
	in_ch.closing!true;
	wg.wait?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousRun153150(Chandef in_ch;Wgdef wg;Wgdef traversing;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousAnonymousRun1531751500 = [1] of {int};
	chan child_AnonymousAnonymousRun1531751501 = [1] of {int};
	int var_jobs = def_var_jobs174; // mand var_jobs
		for(i : 0.. ub_for155_4) {
		for11: skip;
		do
		:: true -> 
			goto defer1
		:: in_ch.deq?state,num_msgs -> 
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			

			if
			:: true -> 
				mu.Lock!false;
				mu.Unlock!false
			:: true;
			fi;
			

			if
			:: true -> 
				traversing.update!var_jobs;
				run AnonymousAnonymousRun153175150(in_ch,wg,traversing,mu,var_jobs,child_AnonymousAnonymousRun1531751500);
				run receiver(child_AnonymousAnonymousRun1531751500)
			:: true;
			fi;
			traversing.update!-1;
			break
		:: in_ch.sync?state -> 
			in_ch.rcving!false;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			

			if
			:: true -> 
				mu.Lock!false;
				mu.Unlock!false
			:: true;
			fi;
			

			if
			:: true -> 
				traversing.update!var_jobs;
				run AnonymousAnonymousRun153175150(in_ch,wg,traversing,mu,var_jobs,child_AnonymousAnonymousRun1531751501);
				run receiver(child_AnonymousAnonymousRun1531751501)
			:: true;
			fi;
			traversing.update!-1;
			break
		od;
		for12_exit: skip;
		for12_end: skip;
		for11_end: skip
	};
	for11_exit: skip;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousAnonymousRun153175150(Chandef in_ch;Wgdef wg;Wgdef traversing;Mutexdef mu;int var_jobs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: var_jobs-1 != -3 -> 
				for(i : 0.. var_jobs-1) {
			for13: skip;
			do
			:: true -> 
				traversing.update!-1;
				break
			:: in_ch.enq!0 -> 
				break
			:: in_ch.sync!false -> 
				in_ch.sending!false;
				break
			od;
			for14_exit: skip;
			for14_end: skip;
			for13_end: skip
		};
		for13_exit: skip
	:: else -> 
		do
		:: true -> 
			for15: skip;
			do
			:: true -> 
				traversing.update!-1;
				break
			:: in_ch.enq!0 -> 
				break
			:: in_ch.sync!false -> 
				in_ch.sending!false;
				break
			od;
			for16_exit: skip;
			for16_end: skip;
			for15_end: skip
		:: true -> 
			break
		od;
		for15_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousRun203150(Chandef in_ch;Wgdef wg;Wgdef traversing;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		num_msgs = 0;
		

		if
		:: in_ch.deq?state,num_msgs;
		:: in_ch.sync?state -> 
			in_ch.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			traversing.update!-1;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
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

