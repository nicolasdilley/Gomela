// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob/ebd6aba6754d073a696e5727158cd0c917ce1019/internal/transport/transport_test.go#L1135
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
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestServerWithMisbehavedClient11350 = [1] of {int};
	run TestServerWithMisbehavedClient1135(child_TestServerWithMisbehavedClient11350);
	run receiver(child_TestServerWithMisbehavedClient11350)
stop_process:skip
}

proctype TestServerWithMisbehavedClient1135(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_stop4070 = [1] of {int};
	chan child_AnonymousTestServerWithMisbehavedClient115711511 = [1] of {int};
	Mutexdef mu;
	Chandef success_ch;
	Mutexdef server_mu;
	run mutexMonitor(server_mu);
	run sync_monitor(success_ch);
	run mutexMonitor(mu);
	run AnonymousTestServerWithMisbehavedClient11571151(success_ch,server_mu,mu,child_AnonymousTestServerWithMisbehavedClient115711511);
	run receiver(child_AnonymousTestServerWithMisbehavedClient115711511);
	mu.Lock!false;
	

	if
	:: true -> 
		mu.Unlock!false
	:: true;
	fi;
	mu.Unlock!false;
	do
	:: true -> 
		for30: skip;
		do
		:: true -> 
			break
		:: success_ch.deq?state,num_msgs -> 
			goto defer1
		:: success_ch.sync?state -> 
			success_ch.rcving!false;
			goto defer1
		:: true -> 
			break
		od;
		for31_exit: skip;
		for31_end: skip;
		mu.Lock!false;
		

		if
		:: true -> 
			mu.Unlock!false;
			do
			:: true -> 
				break
			:: success_ch.deq?state,num_msgs -> 
				goto defer1
			:: success_ch.sync?state -> 
				success_ch.rcving!false;
				goto defer1
			od;
			for32_exit: skip;
			for32_end: skip
		:: true;
		fi;
		mu.Unlock!false;
		for30_end: skip
	od;
	for30_exit: skip;
		defer1: skip;
	run stop407(server_mu,child_stop4070);
	child_stop4070?0;
	stop_process: skip;
	child!0
}
proctype stop407(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_s_connss_conns = -2; // opt var_s_connss_conns
	s_mu.Lock!false;
	s_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousTestServerWithMisbehavedClient11571151(Chandef success_ch;Mutexdef server_mu;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for20: skip;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			mu.Lock!false;
			mu.Unlock!false
		:: true -> 
			success_ch.closing!true;
			goto stop_process
		fi;
		for20_end: skip
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

