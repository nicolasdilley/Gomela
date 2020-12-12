
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example398564910/catalog/filter.go
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
	Chandef fc_Messages;
	Chandef fc_Input;
	int i;
	Chandef fc_Output;
	int rules = -2;
	bool state = false;
	run sync_monitor(fc_Input);
	run sync_monitor(fc_Output);
	run sync_monitor(fc_Messages);
	
	if
	:: true -> 
				for(i : 0.. rules-1) {
for10:			
			if
			:: true -> 
				
				if
				:: fc_Messages.async_send!0;
				:: fc_Messages.sync!0 -> 
					fc_Messages.sending?0
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: fc_Messages.async_send!0;
					:: fc_Messages.sync!0 -> 
						fc_Messages.sending?0
					fi
				:: true;
				fi
			fi;
			
			if
			:: true -> 
				
				if
				:: fc_Messages.async_send!0;
				:: fc_Messages.sync!0 -> 
					fc_Messages.sending?0
				fi
			:: true;
			fi
		}
	:: true;
	fi;
	run Anonymous0();
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		do
		:: true -> 
for21:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto nextRecord
				:: true;
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto nextRecord
				:: true;
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto nextRecord
				:: true;
				fi
			:: true;
			fi
		:: true -> 
			break
		od;
nextRecord:		
	:: true -> 
		break
	od;
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

