#define listenLoop_tokens  ??
#define lb_for887_1  -1
#define ub_for887_2  -1
#define lb_for895_3  -1
#define ub_for895_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example440247525/p2p/server.go
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
	Chandef slots;
	int i;
	int tokens = listenLoop_tokens;
	bool state = false;
	
	if
	:: tokens > 0 -> 
		slots.size = tokens;
		run AsyncChan(slots)
	:: else -> 
		run sync_monitor(slots)
	fi;
	
	if
	:: 0 != -2 && tokens-1 != -3 -> 
				for(i : 0.. tokens-1) {
for10:			
			if
			:: slots.async_send!0;
			:: slots.sync!0 -> 
				slots.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: slots.async_send!0;
			:: slots.sync!0 -> 
				slots.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:		for(i : lb_for887_1.. ub_for887_2) {
for20:		
		if
		:: slots.async_rcv?0;
		:: slots.sync?0;
		fi;
		do
		:: true -> 
for21:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi;
			break
		od;
for21_exit:		
		if
		:: true -> 
			
			if
			:: slots.async_send!0;
			:: slots.sync!0 -> 
				slots.sending?0
			fi
		:: true;
		fi;
		run Anonymous0(slots)
	};
for20_exit:
stop_process:}

proctype Anonymous0(Chandef slots) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: slots.async_send!0;
	:: slots.sync!0 -> 
		slots.sending?0
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

