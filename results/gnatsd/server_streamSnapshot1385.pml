#define lb_for1432_0  -1
#define ub_for1432_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example375738237/server/jetstream_api.go
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
	Chandef acks;
	Chandef inch;
	int i;
	chan child_RegisterNotification0 = [0] of {int};
	chan child_ClearNotification1 = [0] of {int};
	bool state = false;
	
	if
	:: 1 > 0 -> 
		inch.size = 1;
		run AsyncChan(inch)
	:: else -> 
		run sync_monitor(inch)
	fi;
	run RegisterNotification(inch,child_RegisterNotification0);
	child_RegisterNotification0?0;
	
	if
	:: inch.async_rcv?0;
	:: inch.sync?0;
	fi;
	
	if
	:: true -> 
		do
		:: inch.async_rcv?0 -> 
			break
		:: inch.sync?0 -> 
			break
		:: true -> 
			break
		od
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		acks.size = 1;
		run AsyncChan(acks)
	:: else -> 
		run sync_monitor(acks)
	fi;
	
	if
	:: acks.async_send!0;
	:: acks.sync!0 -> 
		acks.sending?0
	fi;
	
	if
	:: lb_for1432_0 != -2 && ub_for1432_1 != -2 -> 
				for(i : lb_for1432_0.. ub_for1432_1) {
for30:			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				do
				:: acks.async_rcv?0 -> 
					break
				:: acks.sync?0 -> 
					break
				:: inch.async_rcv?0 -> 
					goto done;
					break
				:: inch.sync?0 -> 
					goto done;
					break
				:: true -> 
					break
				od
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				do
				:: acks.async_rcv?0 -> 
					break
				:: acks.sync?0 -> 
					break
				:: inch.async_rcv?0 -> 
					goto done;
					break
				:: inch.sync?0 -> 
					goto done;
					break
				:: true -> 
					break
				od
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:done:	;
	child_ClearNotification1?0;
	run ClearNotification(inch,child_ClearNotification1)
stop_process:}

proctype RegisterNotification(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	int r_qsubs = -2;
	int r_psubs = -2;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. r_psubs-1) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		};
				for(i : 0.. r_qsubs-1) {
for20:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype ClearNotification(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
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

