#define loop_numInFlight  3

// https://github.com/vuvuzela/vuvuzela/blob/55ba49f81ad006877ae6b4d76c0958a3ee956441/coordinator/server.go#L273
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
	Chandef flights;
	int num_msgs = 0;
	bool state = false;
	int i;
	int numInFlight = loop_numInFlight;
	

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
			for10483: skip;
			

			if
			:: flights.async_send!0;
			:: flights.sync!false,0 -> 
				flights.sending?state
			fi;
			for10_end483: skip
		};
		for10_exit483: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: flights.async_send!0;
			:: flights.sync!false,0 -> 
				flights.sending?state
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	do
	:: true -> 
		

		if
		:: flights.async_rcv?state,num_msgs;
		:: flights.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			

			if
			:: true -> 
				run go_Anonymous0(flights)
			:: true;
			fi;
			run go_Anonymous1(flights);
			for20_end: skip
		fi
	od;
	for20_exit: skip
stop_process:skip
}

proctype go_Anonymous0(Chandef flights) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip
}
proctype go_Anonymous1(Chandef flights) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: flights.async_send!0;
	:: flights.sync!false,0 -> 
		flights.sending?state
	fi;
	stop_process: skip
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

