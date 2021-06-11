// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/http/serve_test.go#L1472
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
	chan child_TestServeTLS14720 = [1] of {int};
	run TestServeTLS1472(child_TestServeTLS14720);
	run receiver(child_TestServeTLS14720)
stop_process:skip
}

proctype TestServeTLS1472(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close18371 = [1] of {int};
	Mutexdef c_config_mutex;
	Mutexdef c_handshakeMutex;
	chan child_AnonymousTestServeTLS150114900 = [1] of {int};
	Chandef errc;
	Mutexdef s_mu;
	Mutexdef s_nextProtoOnce_m;
	Mutexdef s_ErrorLog_mu;
	Mutexdef s_TLSConfig_mutex;
	Chandef serving;
	Mutexdef tlsConf_mutex;
	run mutexMonitor(tlsConf_mutex);
	

	if
	:: 1 > 0 -> 
		serving.size = 1;
		run AsyncChan(serving)
	:: else -> 
		run sync_monitor(serving)
	fi;
	run mutexMonitor(s_TLSConfig_mutex);
	run mutexMonitor(s_ErrorLog_mu);
	run mutexMonitor(s_nextProtoOnce_m);
	run mutexMonitor(s_mu);
	

	if
	:: 1 > 0 -> 
		errc.size = 1;
		run AsyncChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
	run AnonymousTestServeTLS15011490(serving,errc,tlsConf_mutex,s_TLSConfig_mutex,s_ErrorLog_mu,s_nextProtoOnce_m,s_mu,child_AnonymousTestServeTLS150114900);
	run receiver(child_AnonymousTestServeTLS150114900);
	do
	:: errc.deq?state,num_msgs -> 
		break
	:: errc.sync?state -> 
		errc.rcving!false;
		break
	:: serving.deq?state,num_msgs -> 
		break
	:: serving.sync?state -> 
		serving.rcving!false;
		break
	:: true -> 
		break
	od;
	for10_exit: skip;
	run mutexMonitor(c_handshakeMutex);
	run mutexMonitor(c_config_mutex);
		defer1: skip;
	run Close1837(c_config_mutex,c_handshakeMutex,child_Close18371);
	child_Close18371?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestServeTLS15011490(Chandef serving;Chandef errc;Mutexdef tlsConf_mutex;Mutexdef s_TLSConfig_mutex;Mutexdef s_ErrorLog_mu;Mutexdef s_nextProtoOnce_m;Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: errc.enq!0;
	:: errc.sync!false -> 
		errc.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype Close1837(Mutexdef b_config_mutex;Mutexdef b_handshakeMutex;chan child) {
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

