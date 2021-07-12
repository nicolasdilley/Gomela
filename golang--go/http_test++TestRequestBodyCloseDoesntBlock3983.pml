// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/http/serve_test.go#L3983
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
	chan child_TestRequestBodyCloseDoesntBlock39830 = [1] of {int};
	run TestRequestBodyCloseDoesntBlock3983(child_TestRequestBodyCloseDoesntBlock39830);
	run receiver(child_TestRequestBodyCloseDoesntBlock39830)
stop_process:skip
}

proctype TestRequestBodyCloseDoesntBlock3983(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close18370 = [1] of {int};
	chan child_AnonymousTestRequestBodyCloseDoesntBlock400339891 = [1] of {int};
	Chandef closeConn_ch;
	Mutexdef server_mu;
	Wgdef server_wg;
	Mutexdef server_Config_mu;
	Mutexdef server_TLS_mutex;
	Chandef errCh_ch;
	Chandef readErrCh_ch;
	

	if
	:: 1 > 0 -> 
		readErrCh_ch.size = 1;
		run AsyncChan(readErrCh_ch)
	:: else -> 
		run sync_monitor(readErrCh_ch)
	fi;
	

	if
	:: 2 > 0 -> 
		errCh_ch.size = 2;
		run AsyncChan(errCh_ch)
	:: else -> 
		run sync_monitor(errCh_ch)
	fi;
	run mutexMonitor(server_TLS_mutex);
	run mutexMonitor(server_Config_mu);
	run wgMonitor(server_wg);
	run mutexMonitor(server_mu);
	run sync_monitor(closeConn_ch);
	run AnonymousTestRequestBodyCloseDoesntBlock40033989(readErrCh_ch,errCh_ch,closeConn_ch,server_wg,server_TLS_mutex,server_Config_mu,server_mu,child_AnonymousTestRequestBodyCloseDoesntBlock400339891);
	run receiver(child_AnonymousTestRequestBodyCloseDoesntBlock400339891);
	do
	:: readErrCh_ch.deq?state,num_msgs -> 
		break
	:: readErrCh_ch.sync?state -> 
		readErrCh_ch.rcving!false;
		break
	:: errCh_ch.deq?state,num_msgs -> 
		break
	:: errCh_ch.sync?state -> 
		errCh_ch.rcving!false;
		break
	:: true -> 
		break
	od;
	for10_exit: skip;
		defer2: skip;
	closeConn.closing!true;
		defer1: skip;
	run Close1837(server_wg,server_Config_mu,server_mu,server_TLS_mutex,child_Close18370);
	child_Close18370?0;
	stop_process: skip;
	child!0
}
proctype Close1837(Wgdef b_wg;Mutexdef b_Config_mu;Mutexdef b_mu;Mutexdef b_TLS_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRequestBodyCloseDoesntBlock40033989(Chandef readErrCh_ch;Chandef errCh_ch;Chandef closeConn_ch;Wgdef server_wg;Mutexdef server_TLS_mutex;Mutexdef server_Config_mu;Mutexdef server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errCh_ch.enq!0;
		:: errCh_ch.sync!false -> 
			errCh_ch.sending!false
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: errCh_ch.enq!0;
		:: errCh_ch.sync!false -> 
			errCh_ch.sending!false
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: closeConn_ch.deq?state,num_msgs;
	:: closeConn_ch.sync?state -> 
		closeConn_ch.rcving!false
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

