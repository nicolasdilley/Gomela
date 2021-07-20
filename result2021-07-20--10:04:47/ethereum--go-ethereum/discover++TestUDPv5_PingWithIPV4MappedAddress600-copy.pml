// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/p2p/discover/v5_udp_test.go#L600
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
	chan child_TestUDPv5_PingWithIPV4MappedAddress6000 = [1] of {int};
	run TestUDPv5_PingWithIPV4MappedAddress600(child_TestUDPv5_PingWithIPV4MappedAddress6000);
	run receiver(child_TestUDPv5_PingWithIPV4MappedAddress6000)
stop_process:skip
}

proctype TestUDPv5_PingWithIPV4MappedAddress600(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_close7960 = [1] of {int};
	chan child_waitPacketOut7632 = [1] of {int};
	chan child_AnonymousTestUDPv5_PingWithIPV4MappedAddress6146111 = [1] of {int};
	Chandef done_ch;
	Wgdef test_udp_wg;
	Mutexdef test_udp_trlock;
	Mutexdef test_table_mutex;
	Mutexdef test_pipe_mu;
	run mutexMonitor(test_pipe_mu);
	run mutexMonitor(test_table_mutex);
	run mutexMonitor(test_udp_trlock);
	run wgMonitor(test_udp_wg);
	

	if
	:: 1 > 0 -> 
		done_ch.size = 1;
		run AsyncChan(done_ch)
	:: else -> 
		run sync_monitor(done_ch)
	fi;
	run AnonymousTestUDPv5_PingWithIPV4MappedAddress614611(done_ch,test_udp_wg,test_pipe_mu,test_table_mutex,test_udp_trlock,child_AnonymousTestUDPv5_PingWithIPV4MappedAddress6146111);
	run receiver(child_AnonymousTestUDPv5_PingWithIPV4MappedAddress6146111);
	run waitPacketOut763(test_udp_wg,test_pipe_mu,test_table_mutex,test_udp_trlock,child_waitPacketOut7632);
	child_waitPacketOut7632?0;
	

	if
	:: done_ch.deq?state,num_msgs;
	:: done_ch.sync?state -> 
		done_ch.rcving!false
	fi;
		defer1: skip;
	run close796(test_udp_wg,test_pipe_mu,test_table_mutex,test_udp_trlock,child_close7960);
	child_close7960?0;
	stop_process: skip;
	child!0
}
proctype close796(Wgdef test_udp_wg;Mutexdef test_pipe_mu;Mutexdef test_table_mutex;Mutexdef test_udp_trlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1810 = [1] of {int};
	int var_test_nodesByIDtest_nodesByID = -2; // opt var_test_nodesByIDtest_nodesByID
	run Close181(test_udp_wg,test_udp_trlock,child_Close1810);
	child_Close1810?0;
	stop_process: skip;
	child!0
}
proctype Close181(Wgdef t_wg;Mutexdef t_trlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype AnonymousTestUDPv5_PingWithIPV4MappedAddress614611(Chandef done_ch;Wgdef test_udp_wg;Mutexdef test_pipe_mu;Mutexdef test_table_mutex;Mutexdef test_udp_trlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_handlePing7651 = [1] of {int};
	run handlePing765(test_udp_wg,test_udp_trlock,child_handlePing7651);
	child_handlePing7651?0;
	

	if
	:: done_ch.enq!0;
	:: done_ch.sync!false -> 
		done_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype handlePing765(Wgdef t_wg;Mutexdef t_trlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_sendResponse5951 = [1] of {int};
	run sendResponse595(t_wg,t_trlock,child_sendResponse5951);
	child_sendResponse5951?0;
	stop_process: skip;
	child!0
}
proctype sendResponse595(Wgdef t_wg;Mutexdef t_trlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_send6011 = [1] of {int};
	run send601(t_wg,t_trlock,child_send6011);
	child_send6011?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype send601(Wgdef t_wg;Mutexdef t_trlock;chan child) {
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
proctype waitPacketOut763(Wgdef test_udp_wg;Mutexdef test_pipe_mu;Mutexdef test_table_mutex;Mutexdef test_udp_trlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ln_mu;
	chan child_receive6402 = [1] of {int};
	run receive640(test_pipe_mu,child_receive6402);
	child_receive6402?0;
	

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
	run mutexMonitor(ln_mu);
	

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
proctype receive640(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_mu.Unlock!false;
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

