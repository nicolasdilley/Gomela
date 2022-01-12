// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/micro/micro/blob//service/registry/memory/watcher_test.go#L23
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



init { 
	chan child_TestWatcher230 = [1] of {int};
	run TestWatcher23(child_TestWatcher230);
	run receiver(child_TestWatcher230)
stop_process:skip
}

proctype TestWatcher23(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Next303 = [1] of {int};
	chan child_Stop602 = [1] of {int};
	chan child_Next301 = [1] of {int};
	chan child_AnonymousTestWatcher33240 = [1] of {int};
	Chandef w_exit_ch;
	Chandef w_res_ch;
	run sync_monitor(w_res_ch);
	run sync_monitor(w_exit_ch);
	run AnonymousTestWatcher3324(w_res_ch,w_exit_ch,child_AnonymousTestWatcher33240);
	run receiver(child_AnonymousTestWatcher33240);
	run Next30(w_exit_ch,w_res_ch,child_Next301);
	child_Next301?0;
	run Stop60(w_exit_ch,w_res_ch,child_Stop602);
	child_Stop602?0;
	run Next30(w_exit_ch,w_res_ch,child_Next303);
	child_Next303?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestWatcher3324(Chandef w_res_ch;Chandef w_exit_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: w_res_ch.enq!0;
	:: w_res_ch.sync!false -> 
		w_res_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype Next30(Chandef m_exit_ch;Chandef m_res_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		do
		:: m_res_ch.deq?state,num_msgs -> 
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: m_res_ch.sync?state -> 
			m_res_ch.rcving!false;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: m_exit_ch.deq?state,num_msgs -> 
			goto stop_process
		:: m_exit_ch.sync?state -> 
			m_exit_ch.rcving!false;
			goto stop_process
		od;
		for11_exit: skip;
		for11_end: skip;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype Stop60(Chandef m_exit_ch;Chandef m_res_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: m_exit_ch.deq?state,num_msgs -> 
		goto stop_process
	:: m_exit_ch.sync?state -> 
		m_exit_ch.rcving!false;
		goto stop_process
	:: true -> 
		m_exit_ch.closing!true;
		break
	od;
	for20_exit: skip;
	for20_end: skip;
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

proctype receiver(chan c) {
c?0
}

