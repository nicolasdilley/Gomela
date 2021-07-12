// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/rwmutex_test.go#L29
#define var_numReaders29  ?? // mand var_numReaders29
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
	chan child_doTestParallelReaders290 = [1] of {int};
	run doTestParallelReaders29(var_numReaders29,child_doTestParallelReaders290);
	run receiver(child_doTestParallelReaders290)
stop_process:skip
}

proctype doTestParallelReaders29(int numReaders;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parallelReader200 = [1] of {int};
	Chandef cdone_ch;
	Chandef clocked_ch;
	

	if
	:: var_numReaders > 0 -> 
		clocked_ch.size = var_numReaders;
		run AsyncChan(clocked_ch)
	:: else -> 
		run sync_monitor(clocked_ch)
	fi;
	run sync_monitor(cdone_ch);
		for(i : 0.. var_numReaders-1) {
		for10: skip;
		run parallelReader20(clocked_ch,cdone_ch,child_parallelReader200);
		run receiver(child_parallelReader200);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && var_numReaders-1 != -3 -> 
				for(i : 0.. var_numReaders-1) {
			for21: skip;
			

			if
			:: clocked_ch.deq?state,num_msgs;
			:: clocked_ch.sync?state -> 
				clocked_ch.rcving!false
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: clocked_ch.deq?state,num_msgs;
			:: clocked_ch.sync?state -> 
				clocked_ch.rcving!false
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	

	if
	:: 0 != -2 && var_numReaders-1 != -3 -> 
				for(i : 0.. var_numReaders-1) {
			for31: skip;
			

			if
			:: cdone_ch.deq?state,num_msgs;
			:: cdone_ch.sync?state -> 
				cdone_ch.rcving!false
			fi;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: cdone_ch.deq?state,num_msgs;
			:: cdone_ch.sync?state -> 
				cdone_ch.rcving!false
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype parallelReader20(Chandef clocked_ch;Chandef cdone_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: clocked_ch.enq!0;
	:: clocked_ch.sync!false -> 
		clocked_ch.sending!false
	fi;
	

	if
	:: cdone_ch.enq!0;
	:: cdone_ch.sync!false -> 
		cdone_ch.sending!false
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

