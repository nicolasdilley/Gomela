#define TestEventBufferFuzz_nReaders  0

// https://github.com/hashicorp/consul/blob/master/agent/consul/stream/event_buffer_test.go#L15
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
	chan child_TestEventBufferFuzz150 = [1] of {int};
	run TestEventBufferFuzz15(child_TestEventBufferFuzz150)
stop_process:skip
}

proctype TestEventBufferFuzz15(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestEventBufferFuzz62620 = [1] of {int};
	Chandef errCh;
	int nReaders = TestEventBufferFuzz_nReaders;
	

	if
	:: nReaders > 0 -> 
		errCh.size = nReaders;
		run AsyncChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
		for(i : 0.. nReaders-1) {
		for10: skip;
		run AnonymousTestEventBufferFuzz6262(errCh,child_AnonymousTestEventBufferFuzz62620);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && nReaders-1 != -3 -> 
				for(i : 0.. nReaders-1) {
			for21: skip;
			

			if
			:: errCh.deq?state,num_msgs;
			:: errCh.sync?state -> 
				errCh.rcving!false
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: errCh.deq?state,num_msgs;
			:: errCh.sync?state -> 
				errCh.rcving!false
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestEventBufferFuzz6262(Chandef errCh;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for11: skip;
		

		if
		:: true -> 
			

			if
			:: errCh.enq!0;
			:: errCh.sync!false -> 
				errCh.sending!false
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: errCh.enq!0;
			:: errCh.sync!false -> 
				errCh.sending!false
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: errCh.enq!0;
			:: errCh.sync!false -> 
				errCh.sending!false
			fi;
			goto stop_process
		:: true;
		fi;
		for11_end: skip
	od;
	for11_exit: skip;
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

