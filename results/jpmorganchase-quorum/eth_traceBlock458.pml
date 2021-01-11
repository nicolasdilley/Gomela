#define traceBlock_txs  0
#define traceBlock_threads  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example434979571/eth/api_tracer.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef jobs;
	bool state = false;
	int i;
	int threads = traceBlock_threads;
	int txs = traceBlock_txs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: txs > 0 -> 
		jobs.size = txs;
		run AsyncChan(jobs)
	:: else -> 
		run sync_monitor(jobs)
	fi;
		for(i : 0.. threads-1) {
		for10: skip;
		run go_Anonymous0(jobs);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: txs-1 != -3 -> 
				for(i : 0.. txs-1) {
			for20: skip;
			

			if
			:: jobs.async_send!0;
			:: jobs.sync!0 -> 
				jobs.sending?0
			fi;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for201171: skip;
			

			if
			:: jobs.async_send!0;
			:: jobs.sync!0 -> 
				jobs.sending?0
			fi;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for20_end1171: skip
		:: true -> 
			break
		od;
		for20_exit1171: skip
	fi;
	jobs.closing!true;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef jobs) {
	bool closed; 
	int i;
	bool state;
	do
	:: jobs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: jobs.async_rcv?0;
			:: jobs.sync?0;
			fi;
			for11: skip;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
	stop_process: skip
}
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

