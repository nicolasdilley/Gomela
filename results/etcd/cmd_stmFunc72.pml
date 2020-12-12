#define stmFunc_totalClients  ??
#define stmFunc_clients  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example388592302/tools/benchmark/cmd/stm.go
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
	int totalClients = stmFunc_totalClients;
	Chandef requests;
	int clients = stmFunc_clients;
	bool state = false;
	
	if
	:: totalClients > 0 -> 
		requests.size = totalClients;
		run AsyncChan(requests)
	:: else -> 
		run sync_monitor(requests)
	fi;
	run Anonymous0(requests)
stop_process:}

proctype Anonymous0(Chandef requests) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -2 && stmTotal-1 != -3 -> 
				for(i : 0.. stmTotal-1) {
for20:for21_exit:			
			if
			:: requests.async_send!0;
			:: requests.sync!0 -> 
				requests.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:for21_exit:			
			if
			:: requests.async_send!0;
			:: requests.sync!0 -> 
				requests.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	requests.closing!true;
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

