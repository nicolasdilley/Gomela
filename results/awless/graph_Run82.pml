#define Run_maxCount  ??
#define lb_for97_1  -1
#define ub_for97_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example018730929/graph/diff.go
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
	int maxCount = Run_maxCount;
	int i;
	int missings = -2;
	Chandef processing;
	int extras = -2;
	int commons = -2;
	bool state = false;
	
	if
	:: maxCount > 0 -> 
		processing.size = maxCount;
		run AsyncChan(processing)
	:: else -> 
		run sync_monitor(processing)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: processing.async_send!0;
	:: processing.sync!0 -> 
		processing.sending?0
	fi;
	
	if
	:: lb_for97_1 != -2 && ub_for97_2 != -2 -> 
				for(i : lb_for97_1.. ub_for97_2) {
for10:			do
			:: processing.async_rcv?0 -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
								for(i : 0.. extras-1) {
for11:					
					if
					:: true -> 
						
						if
						:: processing.async_send!0;
						:: processing.sync!0 -> 
							processing.sending?0
						fi
					:: true;
					fi
				};
								for(i : 0.. missings-1) {
for12:					
					if
					:: true -> 
						
						if
						:: processing.async_send!0;
						:: processing.sync!0 -> 
							processing.sending?0
						fi
					:: true;
					fi
				};
								for(i : 0.. commons-1) {
for13:					
					if
					:: true -> 
						
						if
						:: processing.async_send!0;
						:: processing.sync!0 -> 
							processing.sending?0
						fi
					:: true;
					fi
				};
				break
			:: processing.sync?0 -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
								for(i : 0.. extras-1) {
for11:					
					if
					:: true -> 
						
						if
						:: processing.async_send!0;
						:: processing.sync!0 -> 
							processing.sending?0
						fi
					:: true;
					fi
				};
								for(i : 0.. missings-1) {
for12:					
					if
					:: true -> 
						
						if
						:: processing.async_send!0;
						:: processing.sync!0 -> 
							processing.sending?0
						fi
					:: true;
					fi
				};
								for(i : 0.. commons-1) {
for13:					
					if
					:: true -> 
						
						if
						:: processing.async_send!0;
						:: processing.sync!0 -> 
							processing.sending?0
						fi
					:: true;
					fi
				};
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: processing.async_rcv?0 -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
								for(i : 0.. extras-1) {
for11:					
					if
					:: true -> 
						
						if
						:: processing.async_send!0;
						:: processing.sync!0 -> 
							processing.sending?0
						fi
					:: true;
					fi
				};
								for(i : 0.. missings-1) {
for12:					
					if
					:: true -> 
						
						if
						:: processing.async_send!0;
						:: processing.sync!0 -> 
							processing.sending?0
						fi
					:: true;
					fi
				};
								for(i : 0.. commons-1) {
for13:					
					if
					:: true -> 
						
						if
						:: processing.async_send!0;
						:: processing.sync!0 -> 
							processing.sending?0
						fi
					:: true;
					fi
				};
				break
			:: processing.sync?0 -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
								for(i : 0.. extras-1) {
for11:					
					if
					:: true -> 
						
						if
						:: processing.async_send!0;
						:: processing.sync!0 -> 
							processing.sending?0
						fi
					:: true;
					fi
				};
								for(i : 0.. missings-1) {
for12:					
					if
					:: true -> 
						
						if
						:: processing.async_send!0;
						:: processing.sync!0 -> 
							processing.sending?0
						fi
					:: true;
					fi
				};
								for(i : 0.. commons-1) {
for13:					
					if
					:: true -> 
						
						if
						:: processing.async_send!0;
						:: processing.sync!0 -> 
							processing.sending?0
						fi
					:: true;
					fi
				};
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
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

