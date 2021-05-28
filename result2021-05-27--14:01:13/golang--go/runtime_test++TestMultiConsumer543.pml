// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/chan_test.go#L543
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



init { 
	chan child_TestMultiConsumer5430 = [1] of {int};
	run TestMultiConsumer543(child_TestMultiConsumer5430);
	run receiver(child_TestMultiConsumer5430)
stop_process:skip
}

proctype TestMultiConsumer543(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestMultiConsumer5705492 = [1] of {int};
	chan child_AnonymousTestMultiConsumer5565560 = [1] of {int};
	Wgdef wg;
	Chandef r;
	Chandef q;
	

	if
	:: 23 * 3 > 0 -> 
		q.size = 23 * 3;
		run AsyncChan(q)
	:: else -> 
		run sync_monitor(q)
	fi;
	

	if
	:: 23 * 3 > 0 -> 
		r.size = 23 * 3;
		run AsyncChan(r)
	:: else -> 
		run sync_monitor(r)
	fi;
	run wgMonitor(wg);
		for(i : 0.. 23-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestMultiConsumer556556(q,r,wg,child_AnonymousTestMultiConsumer5565560);
		run receiver(child_AnonymousTestMultiConsumer5565560);
		for10_end: skip
	};
	for10_exit: skip;
	run AnonymousTestMultiConsumer570549(q,r,wg,child_AnonymousTestMultiConsumer5705492);
	run receiver(child_AnonymousTestMultiConsumer5705492);
	do
	:: true -> 
		num_msgs = 0;
		

		if
		:: r.deq?state,num_msgs;
		:: r.sync?state -> 
			r.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for30: skip;
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestMultiConsumer556556(Chandef q;Chandef r;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		num_msgs = 0;
		

		if
		:: q.deq?state,num_msgs;
		:: q.sync?state -> 
			q.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for11: skip;
			

			if
			:: r.enq!0;
			:: r.sync!false -> 
				r.sending!false
			fi;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestMultiConsumer570549(Chandef q;Chandef r;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && 271828-1 != -3 -> 
				for(i : 0.. 271828-1) {
			for21: skip;
			

			if
			:: q.enq!0;
			:: q.sync!false -> 
				q.sending!false
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: q.enq!0;
			:: q.sync!false -> 
				q.sending!false
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	q.closing!true;
	wg.wait?0;
	r.closing!true;
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

proctype receiver(chan c) {
c?0
}

