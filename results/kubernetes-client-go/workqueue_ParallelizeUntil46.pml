#define ParallelizeUntil_chunks  0
#define ParallelizeUntil_workers  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example503429202/util/workqueue/parallelizer.go
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
	Chandef toProcess;
	int num_msgs = 0;
	bool state = false;
	int i;
	int workers = ParallelizeUntil_workers;
	int chunks = ParallelizeUntil_chunks;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: chunks > 0 -> 
		toProcess.size = chunks;
		run AsyncChan(toProcess)
	:: else -> 
		run sync_monitor(toProcess)
	fi;
	

	if
	:: 0 != -2 && chunks-1 != -3 -> 
				for(i : 0.. chunks-1) {
			for20589: skip;
			

			if
			:: toProcess.async_send!0;
			:: toProcess.sync!false,0 -> 
				toProcess.sending?state
			fi;
			for20_end589: skip
		};
		for20_exit589: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: toProcess.async_send!0;
			:: toProcess.sync!false,0 -> 
				toProcess.sending?state
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	toProcess.closing!true;
	for30_exit: skip
stop_process:skip
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

