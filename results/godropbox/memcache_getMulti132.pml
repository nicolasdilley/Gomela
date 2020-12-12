#define getMulti_shardMapping  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example128213725/memcache/sharded_client.go
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
	int i;
	int shardMapping = getMulti_shardMapping;
	Chandef resultsChannel;
	int resultsChannel = -2;
	bool state = false;
	
	if
	:: shardMapping > 0 -> 
		resultsChannel.size = shardMapping;
		run AsyncChan(resultsChannel)
	:: else -> 
		run sync_monitor(resultsChannel)
	fi;
	
	if
	:: 0 != -2 && shardMapping-1 != -3 -> 
				for(i : 0.. shardMapping-1) {
for20:						for(i : 0.. resultsChannel-1) {
for21:
			}
		}
	:: else -> 
		do
		:: true -> 
for20:						for(i : 0.. resultsChannel-1) {
for21:
			}
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype go_getMultiHelper(Chandef resultsChannel;int keys) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
				for(i : 0.. keys-1) {
for11:
		}
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. keys-1) {
for12:
			}
		:: true -> 
			
			if
			:: true -> 
								for(i : 0.. keys-1) {
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

