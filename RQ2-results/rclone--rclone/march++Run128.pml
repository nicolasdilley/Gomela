#define Run_checkers  1
#define Run_jobs  0
#define ub_for155_4  1

// https://github.com/rclone/rclone/blob/master/fs/march/march.go#L128
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
	run Run128(child_Run1280)
stop_process:skip
}

proctype Run128(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousRun2031502 = [1] of {int};
	chan child_AnonymousRun1531500 = [1] of {int};
	Chandef in;
	Wgdef traversing;
	Wgdef wg;
	Mutexdef mu;
	int checkers = Run_checkers;
	run mutexMonitor(mu);
	run wgMonitor(wg);
	run wgMonitor(traversing);
	

	if
	:: checkers > 0 -> 
		in.size = checkers;
		run AsyncChan(in)
	:: else -> 
		run sync_monitor(in)
	fi;
		for(i : 0.. checkers-1) {
		for10: skip;
		wg.update!1;
		run AnonymousRun153150(in,wg,traversing,mu,child_AnonymousRun1531500);
		for10_end: skip
	};
	for10_exit: skip;
	traversing.update!1;
	

	if
	:: in.enq!0;
	:: in.sync!false -> 
		in.sending!false
	fi;
	run AnonymousRun203150(in,traversing,wg,mu,child_AnonymousRun2031502);
	traversing.wait?0;
	in.closing!true;
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
proctype AnonymousRun153150(Chandef in;Wgdef wg;Wgdef traversing;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousAnonymousRun1531751500 = [1] of {int};
	chan child_AnonymousAnonymousRun1531751501 = [1] of {int};
	int jobs = Run_jobs;
		for(i : 0.. ub_for155_4) {
		for11: skip;
		do
		:: true -> 
			goto stop_process
		:: in.deq?state,num_msgs -> 
			

			if
			:: true -> 
				goto stop_process
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
				traversing.update!jobs;
				run AnonymousAnonymousRun153175150(in,traversing,wg,mu,jobs,child_AnonymousAnonymousRun1531751500)
			:: true;
			fi;
			traversing.update!-1;
			break
		:: in.sync?state -> 
			in.rcving!false;
			

			if
			:: true -> 
				goto stop_process
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
				traversing.update!jobs;
				run AnonymousAnonymousRun153175150(in,wg,traversing,mu,jobs,child_AnonymousAnonymousRun1531751501)
			:: true;
			fi;
			traversing.update!-1;
			break
		od;
		for11_end: skip
	};
	for11_exit: skip;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype AnonymousAnonymousRun153175150(Chandef in;Wgdef traversing;Wgdef wg;Mutexdef mu;int jobs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: jobs-1 != -3 -> 
				for(i : 0.. jobs-1) {
			for12: skip;
			do
			:: true -> 
				traversing.update!-1;
				break
			:: in.enq!0 -> 
				break
			:: in.sync!false,0 -> 
				in.sending!false;
				break
			od;
			for12_end: skip
		};
		for12_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			do
			:: true -> 
				traversing.update!-1;
				break
			:: in.enq!0 -> 
				break
			:: in.sync!false,0 -> 
				in.sending!false;
				break
			od;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousRun203150(Chandef in;Wgdef traversing;Wgdef wg;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: in.deq?state,num_msgs;
		:: in.sync?state -> 
			in.rcving!false
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.rcving?false;
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.sync!true -> 
		 ch.num_msgs = ch.num_msgs - 1
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

