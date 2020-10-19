#define getMulti_shardMapping  60
#define getMulti_mapping_Keys  60
#define getMulti_resultsChannel  60

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
	int mapping_Keys = getMulti_mapping_Keys;
	Chandef resultsChannel;
	int i;
	int shardMapping = getMulti_shardMapping;
	int resultsChannel = getMulti_resultsChannel;
	bool state = false;
	
	if
	:: shardMapping > 0 -> 
		resultsChannel.size = shardMapping;
		run emptyChan(resultsChannel)
	:: else -> 
		run sync_monitor(resultsChannel)
	fi;
		for(i : 1.. shardMapping) {
for10:		run go_cgetMultiHelper(resultsChannel,mapping_Keys)
	};
	
	if
	:: 0 != -1 && shardMapping-1 != -1 -> 
				for(i : 0.. shardMapping-1) {
for20:						for(i : 1.. resultsChannel) {
for21:
			}
		}
	:: else -> 
		do
		:: true -> 
for20:						for(i : 1.. resultsChannel) {
for21:
			}
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype go_cgetMultiHelper(Chandef resultsChannel;int keys) {
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

