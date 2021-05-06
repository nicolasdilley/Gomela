
// https://github.com/go-kit/kit/blob/master/sd/etcd/client_test.go#L188
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
	run TestWatchPrefix188(child_TestWatchPrefix1880)
stop_process:skip
}

proctype TestWatchPrefix188(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestWatchPrefix1951891 = [1] of {int};
	Chandef ch;
	chan child_newFakeClient1440 = [1] of {int};
	Chandef watchPrefixReturned;
	Chandef event;
	Chandef err;
	run sync_monitor(err);
	run sync_monitor(event);
	

	if
	:: 1 > 0 -> 
		watchPrefixReturned.size = 1;
		run AsyncChan(watchPrefixReturned)
	:: else -> 
		run sync_monitor(watchPrefixReturned)
	fi;
	run newFakeClient144(event,err,child_newFakeClient1440);
	child_newFakeClient1440?0;
	run sync_monitor(ch);
	run AnonymousTestWatchPrefix195189(err,event,watchPrefixReturned,ch,child_AnonymousTestWatchPrefix1951891);
	

	if
	:: ch.deq?state,num_msgs;
	:: ch.sync?state -> 
		ch.rcving!false
	fi;
	

	if
	:: event.enq!0;
	:: event.sync!false -> 
		event.sending!false
	fi;
	

	if
	:: ch.deq?state,num_msgs;
	:: ch.sync?state -> 
		ch.rcving!false
	fi;
	

	if
	:: err.enq!0;
	:: err.sync!false -> 
		err.sending!false
	fi;
	do
	:: watchPrefixReturned.deq?state,num_msgs -> 
		goto for10_exit
	:: watchPrefixReturned.sync?state -> 
		watchPrefixReturned.rcving!false;
		goto for10_exit
	:: true -> 
		break
	od;
	stop_process: skip;
	child!0
}
proctype newFakeClient144(Chandef event;Chandef err;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTestWatchPrefix195189(Chandef err;Chandef event;Chandef watchPrefixReturned;Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WatchPrefix1411 = [1] of {int};
	run WatchPrefix141(ch,child_WatchPrefix1411);
	child_WatchPrefix1411?0;
	

	if
	:: watchPrefixReturned.enq!0;
	:: watchPrefixReturned.sync!false -> 
		watchPrefixReturned.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype WatchPrefix141(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: ch.enq!0;
	:: ch.sync!false -> 
		ch.sending!false
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
		:: ch.enq!0;
		:: ch.sync!false -> 
			ch.sending!false
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

