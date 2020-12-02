#define Search_engine_initOptions_NumShards  3

// /tmp/clone-example613129771/engine/engine.go
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
	Chandef rankerReturnChannel;
	int rankerOutput_docs = -2;
	int request_Tokens = -2;
	bool state = false;
	int querySegments = -2;
	int engine_initOptions_NumShards = Search_engine_initOptions_NumShards;
	int i;
	
	if
	:: true -> 
				for(i : 0.. querySegments-1) {
for10:
		}
	:: true -> 
				for(i : 0.. request_Tokens-1) {
for20:
		}
	:: true -> 
				for(i : 0.. request_Tokens-1) {
for20:
		}
	fi;
	
	if
	:: engine_initOptions_NumShards > 0 -> 
		rankerReturnChannel.size = engine_initOptions_NumShards;
		run AsyncChan(rankerReturnChannel)
	:: else -> 
		run sync_monitor(rankerReturnChannel)
	fi;
	
	if
	:: 0 != -2 && engine_initOptions_NumShards-1 != -3 -> 
				for(i : 0.. engine_initOptions_NumShards-1) {
for30:
		}
	:: else -> 
		do
		:: true -> 
for30:
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: true -> 
		
		if
		:: 0 != -2 && engine_initOptions_NumShards-1 != -3 -> 
						for(i : 0.. engine_initOptions_NumShards-1) {
for40:				
				if
				:: rankerReturnChannel.async_rcv?0;
				:: rankerReturnChannel.sync?0;
				fi;
				
				if
				:: true -> 
										for(i : 0.. rankerOutput_docs-1) {
for41:
					}
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for40:				
				if
				:: rankerReturnChannel.async_rcv?0;
				:: rankerReturnChannel.sync?0;
				fi;
				
				if
				:: true -> 
										for(i : 0.. rankerOutput_docs-1) {
for41:
					}
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for40_exit:
	:: true -> 
		
		if
		:: 0 != -2 && engine_initOptions_NumShards-1 != -3 -> 
						for(i : 0.. engine_initOptions_NumShards-1) {
for50:				do
				:: rankerReturnChannel.async_rcv?0 -> 
					
					if
					:: true -> 
												for(i : 0.. rankerOutput_docs-1) {
for51:
						}
					:: true;
					fi;
					break
				:: rankerReturnChannel.sync?0 -> 
					
					if
					:: true -> 
												for(i : 0.. rankerOutput_docs-1) {
for51:
						}
					:: true;
					fi;
					break
				:: true -> 
					break
				od
			}
		:: else -> 
			do
			:: true -> 
for50:				do
				:: rankerReturnChannel.async_rcv?0 -> 
					
					if
					:: true -> 
												for(i : 0.. rankerOutput_docs-1) {
for51:
						}
					:: true;
					fi;
					break
				:: rankerReturnChannel.sync?0 -> 
					
					if
					:: true -> 
												for(i : 0.. rankerOutput_docs-1) {
for51:
						}
					:: true;
					fi;
					break
				:: true -> 
					break
				od
			:: true -> 
				break
			od
		fi;
for50_exit:
	:: true -> 
		
		if
		:: 0 != -2 && engine_initOptions_NumShards-1 != -3 -> 
						for(i : 0.. engine_initOptions_NumShards-1) {
for50:				do
				:: rankerReturnChannel.async_rcv?0 -> 
					
					if
					:: true -> 
												for(i : 0.. rankerOutput_docs-1) {
for51:
						}
					:: true;
					fi;
					break
				:: rankerReturnChannel.sync?0 -> 
					
					if
					:: true -> 
												for(i : 0.. rankerOutput_docs-1) {
for51:
						}
					:: true;
					fi;
					break
				:: true -> 
					break
				od
			}
		:: else -> 
			do
			:: true -> 
for50:				do
				:: rankerReturnChannel.async_rcv?0 -> 
					
					if
					:: true -> 
												for(i : 0.. rankerOutput_docs-1) {
for51:
						}
					:: true;
					fi;
					break
				:: rankerReturnChannel.sync?0 -> 
					
					if
					:: true -> 
												for(i : 0.. rankerOutput_docs-1) {
for51:
						}
					:: true;
					fi;
					break
				:: true -> 
					break
				od
			:: true -> 
				break
			od
		fi;
for50_exit:
	fi;
	goto stop_process
stop_process:}

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

