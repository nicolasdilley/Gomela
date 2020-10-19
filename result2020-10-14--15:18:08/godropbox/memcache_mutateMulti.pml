#define mutateMulti_shards  60
#define mutateMultiHelper_keys  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example253377481/memcache/sharded_client.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	Chandef resultsChannel;
	int i;
	int shards = mutateMulti_shards;
	bool state = false;
	
	if
	:: shards > 0 -> 
		resultsChannel.size = shards;
		run emptyChan(resultsChannel)
	:: else -> 
		run sync_monitor(resultsChannel)
	fi;
		for(i : 1.. shards) {
for10:		run go_cmutateMultiHelper(resultsChannel)
	};
	
	if
	:: 0 != -1 && shards-1 != -1 -> 
				for(i : 0.. shards-1) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype go_cmutateMultiHelper(Chandef resultsChannel) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
				for(i : 1.. keys) {
for11:
		}
	:: true -> 
		
		if
		:: true -> 
						for(i : 1.. keys) {
for12:
			}
		:: true -> 
			
			if
			:: true -> 
								for(i : 1.. keys) {
for13:
				}
			fi
		fi
	fi;
	
	if
	:: true -> 
				for(i : 1.. keys) {
for14:
		}
	:: true;
	fi;
	
	if
	:: resultsChannel.async_send!0;
	:: resultsChannel.sync!0 -> 
		resultsChannel.sending?0
	fi;
stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

