// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-kit/kit/blob/60e8424101af501c525efaf67c0a2edf08667f80/sd/etcd/client_test.go#L188
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
	chan child_TestWatchPrefix1880 = [1] of {int};
	run TestWatchPrefix188(child_TestWatchPrefix1880);
	run receiver(child_TestWatchPrefix1880)
stop_process:skip
}

proctype TestWatchPrefix188(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestWatchPrefix1951941 = [1] of {int};
	Chandef ch_ch;
	chan child_newFakeClient1440 = [1] of {int};
	Chandef watchPrefixReturned_ch;
	Chandef event_ch;
	Chandef err_ch;
	run sync_monitor(err_ch);
	run sync_monitor(event_ch);
	

	if
	:: 1 > 0 -> 
		watchPrefixReturned_ch.size = 1;
		run AsyncChan(watchPrefixReturned_ch)
	:: else -> 
		run sync_monitor(watchPrefixReturned_ch)
	fi;
	run newFakeClient144(event_ch,err_ch,child_newFakeClient1440);
	child_newFakeClient1440?0;
	run sync_monitor(ch_ch);
	run AnonymousTestWatchPrefix195194(ch_ch,err_ch,event_ch,watchPrefixReturned_ch,child_AnonymousTestWatchPrefix1951941);
	run receiver(child_AnonymousTestWatchPrefix1951941);
	

	if
	:: ch_ch.deq?state,num_msgs;
	:: ch_ch.sync?state -> 
		ch_ch.rcving!false
	fi;
	

	if
	:: event_ch.enq!0;
	:: event_ch.sync!false -> 
		event_ch.sending!false
	fi;
	

	if
	:: ch.deq?state,num_msgs;
	:: ch.sync?state -> 
		ch.rcving!false
	fi;
	

	if
	:: err_ch.enq!0;
	:: err_ch.sync!false -> 
		err_ch.sending!false
	fi;
	do
	:: watchPrefixReturned_ch.deq?state,num_msgs -> 
		goto for20_exit
	:: watchPrefixReturned_ch.sync?state -> 
		watchPrefixReturned_ch.rcving!false;
		goto for20_exit
	:: true -> 
		break
	od;
	for20_exit: skip;
	stop_process: skip;
	child!0
}
proctype newFakeClient144(Chandef event_ch;Chandef err_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTestWatchPrefix195194(Chandef ch_ch;Chandef err_ch;Chandef event_ch;Chandef watchPrefixReturned_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WatchPrefix1411 = [1] of {int};
	run WatchPrefix141(ch_ch,child_WatchPrefix1411);
	child_WatchPrefix1411?0;
	

	if
	:: watchPrefixReturned_ch.enq!0;
	:: watchPrefixReturned_ch.sync!false -> 
		watchPrefixReturned_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype WatchPrefix141(Chandef ch_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: ch_ch.enq!0;
	:: ch_ch.sync!false -> 
		ch_ch.sending!false
	fi;
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: ch_ch.enq!0;
		:: ch_ch.sync!false -> 
			ch_ch.sending!false
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
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

