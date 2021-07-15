#define podsRunning_pods_Items  3

// https://github.com/kubernetes/kubernetes/blob/master/test/e2e/framework/pod/resource.go#L278
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
	chan child_podsRunning2780 = [1] of {int};
	run podsRunning278(child_podsRunning2780)
stop_process:skip
}

proctype podsRunning278(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymouspodsRunning2862860 = [1] of {int};
	Chandef errorChan;
	int pods_Items = podsRunning_pods_Items;
	run sync_monitor(errorChan);
		for(i : 0.. pods_Items-1) {
		for10: skip;
		run AnonymouspodsRunning286286(errorChan,child_AnonymouspodsRunning2862860);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: pods_Items-1 != -3 -> 
				for(i : 0.. pods_Items-1) {
			for20: skip;
			

			if
			:: errorChan.deq?state,num_msgs;
			:: errorChan.sync?state -> 
				errorChan.rcving!false
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			

			if
			:: errorChan.deq?state,num_msgs;
			:: errorChan.sync?state -> 
				errorChan.rcving!false
			fi;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymouspodsRunning286286(Chandef errorChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: errorChan.enq!0;
	:: errorChan.sync!false -> 
		errorChan.sending!false
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

