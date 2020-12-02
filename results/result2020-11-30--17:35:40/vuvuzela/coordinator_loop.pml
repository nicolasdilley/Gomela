#define loop_numInFlight  3

// /tmp/clone-example101491844/coordinator/server.go
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
	Chandef flights;
	int i;
	int numInFlight = loop_numInFlight;
	bool state = false;
	
	if
	:: numInFlight > 0 -> 
		flights.size = numInFlight;
		run AsyncChan(flights)
	:: else -> 
		run sync_monitor(flights)
	fi;
	
	if
	:: 0 != -2 && numInFlight-1 != -3 -> 
				for(i : 0.. numInFlight-1) {
for10:			
			if
			:: flights.async_send!0;
			:: flights.sync!0 -> 
				flights.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: flights.async_send!0;
			:: flights.sync!0 -> 
				flights.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	do
	:: flights.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: flights.async_rcv?0;
			:: flights.sync?0;
			fi;
			
			if
			:: true -> 
				run Anonymous0(flights)
			:: true;
			fi;
			run Anonymous1(flights)
		fi
	od
stop_process:}

proctype Anonymous0(Chandef flights) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous1(Chandef flights) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: flights.async_send!0;
	:: flights.sync!0 -> 
		flights.sending?0
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
