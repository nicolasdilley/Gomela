#define updateMessageDispositions_partitions  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example764585296/pubsub/azuresb/azuresb.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef sem;
	int num_msgs = 0;
	bool state = false;
	int i;
	int partitions = updateMessageDispositions_partitions;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 5 > 0 -> 
		sem.size = 5;
		run AsyncChan(sem)
	:: else -> 
		run sync_monitor(sem)
	fi;
		for(i : 0.. partitions-1) {
		for20: skip;
		

		if
		:: sem.async_send!0;
		:: sem.sync!false,0 -> 
			sem.sending?state
		fi;
		run go_Anonymous0(sem);
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: 0 != -2 && 5-1 != -3 -> 
				for(i : 0.. 5-1) {
			for30420: skip;
			

			if
			:: sem.async_send!0;
			:: sem.sync!false,0 -> 
				sem.sending?state
			fi;
			for30_end420: skip
		};
		for30_exit420: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: sem.async_send!0;
			:: sem.sync!false,0 -> 
				sem.sending?state
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef sem) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	

	if
	:: sem.async_rcv?state,num_msgs;
	:: sem.sync?state,num_msgs;
	fi
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
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;  // sending channel is open
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
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}
