// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/valyala/fasthttp/blob/19fcd408632d6dae8425ae95c6c62a25c823ff81/client_test.go#L2451
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
	chan child_TestClientTLSHandshakeTimeout24510 = [1] of {int};
	run TestClientTLSHandshakeTimeout2451(child_TestClientTLSHandshakeTimeout24510);
	run receiver(child_TestClientTLSHandshakeTimeout24510)
stop_process:skip
}

proctype TestClientTLSHandshakeTimeout2451(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get3101 = [1] of {int};
	Mutexdef client_mLock;
	Mutexdef client_TLSConfig_mutex;
	chan child_AnonymousTestClientTLSHandshakeTimeout246824650 = [1] of {int};
	Chandef complete_ch;
	run sync_monitor(complete_ch);
	run AnonymousTestClientTLSHandshakeTimeout24682465(complete_ch,child_AnonymousTestClientTLSHandshakeTimeout246824650);
	run receiver(child_AnonymousTestClientTLSHandshakeTimeout246824650);
	run mutexMonitor(client_TLSConfig_mutex);
	run mutexMonitor(client_mLock);
	run Get310(client_mLock,client_TLSConfig_mutex,child_Get3101);
	child_Get3101?0;
		defer1: skip;
	complete_ch.closing!true;
	stop_process: skip;
	child!0
}
proctype AnonymousTestClientTLSHandshakeTimeout24682465(Chandef complete_ch;chan child) {
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
	:: complete_ch.deq?state,num_msgs;
	:: complete_ch.sync?state -> 
		complete_ch.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype Get310(Mutexdef c_mLock;Mutexdef c_TLSConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_clientGetURL8411 = [1] of {int};
	run clientGetURL841(c_mLock,c_TLSConfig_mutex,child_clientGetURL8411);
	child_clientGetURL8411?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype clientGetURL841(Mutexdef c_mLock;Mutexdef c_TLSConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_doRequestFollowRedirectsBuffer9661 = [1] of {int};
	run doRequestFollowRedirectsBuffer966(c_mLock,c_TLSConfig_mutex,child_doRequestFollowRedirectsBuffer9661);
	child_doRequestFollowRedirectsBuffer9661?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype doRequestFollowRedirectsBuffer966(Mutexdef c_mLock;Mutexdef c_TLSConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_doRequestFollowRedirects9831 = [1] of {int};
	run doRequestFollowRedirects983(c_mLock,c_TLSConfig_mutex,child_doRequestFollowRedirects9831);
	child_doRequestFollowRedirects9831?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype doRequestFollowRedirects983(Mutexdef c_mLock;Mutexdef c_TLSConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
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

