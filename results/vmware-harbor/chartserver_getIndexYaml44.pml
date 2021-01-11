#define getIndexYaml_initialItemCount  1
#define getIndexYaml_namespaces  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example335058053/src/chartserver/handler_repo.go
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
	Chandef workerPool;
	Chandef mergeDone;
	Chandef errorChan;
	Chandef resultChan;
	bool state = false;
	int i;
	int namespaces = getIndexYaml_namespaces;
	int initialItemCount = getIndexYaml_initialItemCount;
	

	if
	:: 1 > 0 -> 
		resultChan.size = 1;
		run AsyncChan(resultChan)
	:: else -> 
		run sync_monitor(resultChan)
	fi;
	

	if
	:: 1 > 0 -> 
		errorChan.size = 1;
		run AsyncChan(errorChan)
	:: else -> 
		run sync_monitor(errorChan)
	fi;
	

	if
	:: 1 > 0 -> 
		mergeDone.size = 1;
		run AsyncChan(mergeDone)
	:: else -> 
		run sync_monitor(mergeDone)
	fi;
	

	if
	:: initialItemCount > 0 -> 
		workerPool.size = initialItemCount;
		run AsyncChan(workerPool)
	:: else -> 
		run sync_monitor(workerPool)
	fi;
	

	if
	:: 0 != -2 && initialItemCount-1 != -3 -> 
				for(i : 0.. initialItemCount-1) {
			for10656: skip;
			

			if
			:: workerPool.async_send!0;
			:: workerPool.sync!0 -> 
				workerPool.sending?0
			fi;
			for10_end656: skip
		};
		for10_exit656: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: workerPool.async_send!0;
			:: workerPool.sync!0 -> 
				workerPool.sending?0
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run go_Anonymous0(resultChan,errorChan,mergeDone,workerPool);
	LOOP: skip;
			for(i : 0.. namespaces-1) {
		for30: skip;
		do
		:: errorChan.async_rcv?0 -> 
			goto LOOP;
			break
		:: errorChan.sync?0 -> 
			goto LOOP;
			break
		:: true;
		od;
		

		if
		:: workerPool.async_rcv?0;
		:: workerPool.sync?0;
		fi;
		run go_Anonymous1(resultChan,errorChan,mergeDone,workerPool);
		for30_end: skip
	};
	for30_exit: skip;
	resultChan.closing!true;
	

	if
	:: mergeDone.async_rcv?0;
	:: mergeDone.sync?0;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef resultChan;Chandef errorChan;Chandef mergeDone;Chandef workerPool) {
	bool closed; 
	int i;
	bool state;
	do
	:: resultChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: resultChan.async_rcv?0;
			:: resultChan.sync?0;
			fi;
			for20: skip;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	stop_process: skip;
	

	if
	:: mergeDone.async_send!0;
	:: mergeDone.sync!0 -> 
		mergeDone.sending?0
	fi
}
proctype go_Anonymous1(Chandef resultChan;Chandef errorChan;Chandef mergeDone;Chandef workerPool) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: errorChan.async_send!0;
			:: errorChan.sync!0 -> 
				errorChan.sending?0
			fi
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: resultChan.async_send!0;
	:: resultChan.sync!0 -> 
		resultChan.sending?0
	fi;
	stop_process: skip;
	

	if
	:: workerPool.async_send!0;
	:: workerPool.sync!0 -> 
		workerPool.sending?0
	fi
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

