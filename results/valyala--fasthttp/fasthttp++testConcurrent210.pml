#define concurrency210  3

// https://github.com/valyala/fasthttp/blob/master/compress_test.go#L210
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
	chan child_testConcurrent2100 = [1] of {int};
	run testConcurrent210(concurrency210,child_testConcurrent2100)
stop_process:skip
}

proctype testConcurrent210(int concurrency;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoustestConcurrent2132130 = [1] of {int};
	Chandef ch;
	

	if
	:: concurrency > 0 -> 
		ch.size = concurrency;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
		for(i : 0.. concurrency-1) {
		for10: skip;
		run AnonymoustestConcurrent213213(ch,child_AnonymoustestConcurrent2132130);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && concurrency-1 != -3 -> 
				for(i : 0.. concurrency-1) {
			for21: skip;
			do
			:: ch.deq?state,num_msgs -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: ch.sync?state -> 
				ch.rcving!false;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				goto stop_process
			od;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			do
			:: ch.deq?state,num_msgs -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: ch.sync?state -> 
				ch.rcving!false;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				goto stop_process
			od;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymoustestConcurrent213213(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: ch.enq!0;
		:: ch.sync!false -> 
			ch.sending!false
		fi
	:: true;
	fi;
	

	if
	:: ch.enq!0;
	:: ch.sync!false -> 
		ch.sending!false
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

