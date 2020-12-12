#define StartConsuming_concurrency  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example309770998/v1/brokers/sqs/sqs.go
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
	Chandef pool;
	int i;
	chan child_consume0 = [0] of {int};
	Chandef deliveries;
	Chandef b_stopReceivingChan;
	int concurrency = StartConsuming_concurrency;
	bool state = false;
	
	if
	:: concurrency > 0 -> 
		deliveries.size = concurrency;
		run AsyncChan(deliveries)
	:: else -> 
		run sync_monitor(deliveries)
	fi;
	
	if
	:: concurrency > 0 -> 
		pool.size = concurrency;
		run AsyncChan(pool)
	:: else -> 
		run sync_monitor(pool)
	fi;
	
	if
	:: 0 != -2 && concurrency-1 != -3 -> 
				for(i : 0.. concurrency-1) {
for10:			
			if
			:: pool.async_send!0;
			:: pool.sync!0 -> 
				pool.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: pool.async_send!0;
			:: pool.sync!0 -> 
				pool.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	run sync_monitor(b_stopReceivingChan);
	run Anonymous0(deliveries,pool,b_stopReceivingChan);
	run consume(deliveries,pool,child_consume0);
	child_consume0?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef deliveries;Chandef pool;Chandef b_stopReceivingChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		do
		:: pool.async_rcv?0 -> 
			
			if
			:: true -> 
				
				if
				:: deliveries.async_send!0;
				:: deliveries.sync!0 -> 
					deliveries.sending?0
				fi
			:: true -> 
				
				if
				:: pool.async_send!0;
				:: pool.sync!0 -> 
					pool.sending?0
				fi
			:: true -> 
				
				if
				:: pool.async_send!0;
				:: pool.sync!0 -> 
					pool.sending?0
				fi
			fi;
			break
		:: pool.sync?0 -> 
			
			if
			:: true -> 
				
				if
				:: deliveries.async_send!0;
				:: deliveries.sync!0 -> 
					deliveries.sending?0
				fi
			:: true -> 
				
				if
				:: pool.async_send!0;
				:: pool.sync!0 -> 
					pool.sending?0
				fi
			:: true -> 
				
				if
				:: pool.async_send!0;
				:: pool.sync!0 -> 
					pool.sending?0
				fi
			fi;
			break
		od
	od;
for20_exit:stop_process:
}
proctype consume(Chandef deliveries;Chandef pool;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef errorsChan;
	run sync_monitor(errorsChan);
	do
	:: true -> 
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for30_exit:stop_process:	child!0
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

