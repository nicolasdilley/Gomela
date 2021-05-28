// num_comm_params=6
// num_mand_comm_params=1
// num_opt_comm_params=5

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/sync/map_test.go#L115
#define TestConcurrentRange_int64_runtime_GOMAXPROCS_0__  ??
#define ub_for134_4  -2
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
	chan child_TestConcurrentRange1150 = [1] of {int};
	run TestConcurrentRange115(child_TestConcurrentRange1150);
	run receiver(child_TestConcurrentRange1150)
stop_process:skip
}

proctype TestConcurrentRange115(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Range785 = [1] of {int};
	chan child_Range784 = [1] of {int};
	chan child_AnonymousTestConcurrentRange1321322 = [1] of {int};
	Wgdef wg;
	Chandef done;
	chan child_Store371 = [1] of {int};
	chan child_Store370 = [1] of {int};
	Mutexdef m_mu;
	int iters = -2; // opt iters
	int int64_runtime_GOMAXPROCS_0__ = TestConcurrentRange_int64_runtime_GOMAXPROCS_0__; // mand int64_runtime_GOMAXPROCS_0__
	int int64_1_ = -2; // opt int64_1_
	int mapSize = -2; // opt mapSize
	run mutexMonitor(m_mu);
	

	if
	:: 0 != -2 && mapSize != -2 -> 
				for(i : 0.. mapSize) {
			for11: skip;
			run Store37(m_mu,child_Store371);
			child_Store371?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Store37(m_mu,child_Store370);
			child_Store370?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run sync_monitor(done);
	run wgMonitor(wg);
		for(i : 0.. int64_runtime_GOMAXPROCS_0__-1) {
		for20: skip;
		wg.update!1;
		run AnonymousTestConcurrentRange132132(done,wg,m_mu,mapSize,int64_1_,child_AnonymousTestConcurrentRange1321322);
		run receiver(child_AnonymousTestConcurrentRange1321322);
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: 0 != -2 && iters-1 != -3 -> 
				for(i : 0.. iters-1) {
			for35: skip;
			run Range78(m_mu,child_Range785);
			child_Range785?0;
			for35_end: skip
		};
		for35_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			run Range78(m_mu,child_Range784);
			child_Range784?0;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
		defer1: skip;
	done.closing!true;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype Store37(Mutexdef m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_mu.Lock!false;
	m_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousTestConcurrentRange132132(Chandef done;Wgdef wg;Mutexdef m_mu;int mapSize;int int64_1_;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Store378 = [1] of {int};
	chan child_Load309 = [1] of {int};
	chan child_Store376 = [1] of {int};
	chan child_Load307 = [1] of {int};
	chan child_Store374 = [1] of {int};
	chan child_Load305 = [1] of {int};
	chan child_Store372 = [1] of {int};
	chan child_Load303 = [1] of {int};
	

	if
	:: 0 != -2 && ub_for134_4 != -2 -> 
				for(i : 0.. ub_for134_4) {
			for25: skip;
			do
			:: done.deq?state,num_msgs -> 
				goto defer1
			:: done.sync?state -> 
				done.rcving!false;
				goto defer1
			:: true -> 
				break
			od;
			for26_exit: skip;
			

			if
			:: 0 != -2 && mapSize-1 != -3 -> 
								for(i : 0.. mapSize-1) {
					for28: skip;
					

					if
					:: true -> 
						run Store37(m_mu,child_Store378);
						child_Store378?0
					:: true -> 
						run Load30(m_mu,child_Load309);
						child_Load309?0
					fi;
					for28_end: skip
				};
				for28_exit: skip
			:: else -> 
				do
				:: true -> 
					for27: skip;
					

					if
					:: true -> 
						run Store37(m_mu,child_Store376);
						child_Store376?0
					:: true -> 
						run Load30(m_mu,child_Load307);
						child_Load307?0
					fi;
					for27_end: skip
				:: true -> 
					break
				od;
				for27_exit: skip
			fi;
			for25_end: skip
		};
		for25_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			do
			:: done.deq?state,num_msgs -> 
				goto defer1
			:: done.sync?state -> 
				done.rcving!false;
				goto defer1
			:: true -> 
				break
			od;
			for22_exit: skip;
			

			if
			:: 0 != -2 && mapSize-1 != -3 -> 
								for(i : 0.. mapSize-1) {
					for24: skip;
					

					if
					:: true -> 
						run Store37(m_mu,child_Store374);
						child_Store374?0
					:: true -> 
						run Load30(m_mu,child_Load305);
						child_Load305?0
					fi;
					for24_end: skip
				};
				for24_exit: skip
			:: else -> 
				do
				:: true -> 
					for23: skip;
					

					if
					:: true -> 
						run Store37(m_mu,child_Store372);
						child_Store372?0
					:: true -> 
						run Load30(m_mu,child_Load303);
						child_Load303?0
					fi;
					for23_end: skip
				:: true -> 
					break
				od;
				for23_exit: skip
			fi;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Load30(Mutexdef m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_mu.RLock!false;
	m_mu.RUnlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Range78(Mutexdef m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Load304 = [1] of {int};
	chan child_Load305 = [1] of {int};
	int keys = -2; // opt keys
	int m_dirty = -2; // opt m_dirty
	m_mu.RLock!false;
	m_mu.RUnlock!false;
	

	if
	:: keys-1 != -3 -> 
				for(i : 0.. keys-1) {
			for33: skip;
			run Load30(m_mu,child_Load304);
			child_Load304?0;
			

			if
			:: true -> 
				goto for33_end
			:: true;
			fi;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for33_end: skip
		};
		for33_exit: skip
	:: else -> 
		do
		:: true -> 
			for34: skip;
			run Load30(m_mu,child_Load305);
			child_Load305?0;
			

			if
			:: true -> 
				goto for34_end
			:: true;
			fi;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for34_end: skip
		:: true -> 
			break
		od;
		for34_exit: skip
	fi;
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

