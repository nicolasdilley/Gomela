// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/valyala/fasthttp/blob//workerpool_test.go#L56
#define def_var_concurrency60  ?? // mand concurrency line 60
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
	chan child_TestWorkerPoolMaxWorkersCountConcurrent560 = [1] of {int};
	run TestWorkerPoolMaxWorkersCountConcurrent56(child_TestWorkerPoolMaxWorkersCountConcurrent560);
	run receiver(child_TestWorkerPoolMaxWorkersCountConcurrent560)
stop_process:skip
}

proctype TestWorkerPoolMaxWorkersCountConcurrent56(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestWorkerPoolMaxWorkersCountConcurrent62600 = [1] of {int};
	Chandef ch_ch;
	int var_concurrency = def_var_concurrency60; // mand var_concurrency
	

	if
	:: var_concurrency > 0 -> 
		ch_ch.size = var_concurrency;
		run AsyncChan(ch_ch)
	:: else -> 
		run sync_monitor(ch_ch)
	fi;
		for(i : 0.. var_concurrency-1) {
		for10: skip;
		run AnonymousTestWorkerPoolMaxWorkersCountConcurrent6260(ch_ch,child_AnonymousTestWorkerPoolMaxWorkersCountConcurrent62600);
		run receiver(child_AnonymousTestWorkerPoolMaxWorkersCountConcurrent62600);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && var_concurrency-1 != -3 -> 
				for(i : 0.. var_concurrency-1) {
			for22: skip;
			do
			:: ch_ch.deq?state,num_msgs -> 
				break
			:: ch_ch.sync?state -> 
				ch_ch.rcving!false;
				break
			:: true -> 
				break
			od;
			for23_exit: skip;
			for23_end: skip;
			for22_end: skip
		};
		for22_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			do
			:: ch_ch.deq?state,num_msgs -> 
				break
			:: ch_ch.sync?state -> 
				ch_ch.rcving!false;
				break
			:: true -> 
				break
			od;
			for21_exit: skip;
			for21_end: skip;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestWorkerPoolMaxWorkersCountConcurrent6260(Chandef ch_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: ch_ch.enq!0;
	:: ch_ch.sync!false -> 
		ch_ch.sending!false
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

proctype receiver(chan c) {
c?0
}

