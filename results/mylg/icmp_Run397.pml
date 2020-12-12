
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example353457528/icmp/trace.go
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
	Chandef c;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		c.size = 1;
		run AsyncChan(c)
	:: else -> 
		run sync_monitor(c)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0(c);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef c) {
	bool closed; 
	int i;
	bool state;
LOOP:		
	if
	:: 1 != -2 && i_maxTTL != -2 -> 
				for(i : 1.. i_maxTTL) {
for10:			
			if
			:: 0 != -2 && retry-1 != -3 -> 
								for(i : 0.. retry-1) {
for11:					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for11:					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for11_exit:			
			if
			:: c.async_send!0;
			:: c.sync!0 -> 
				c.sending?0
			fi;
			do
			:: true -> 
for12:				
				if
				:: true -> 
					goto LOOP
				:: true;
				fi
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: 0 != -2 && retry-1 != -3 -> 
								for(i : 0.. retry-1) {
for11:					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for11:					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for11_exit:			
			if
			:: c.async_send!0;
			:: c.sync!0 -> 
				c.sending?0
			fi;
			do
			:: true -> 
for12:				
				if
				:: true -> 
					goto LOOP
				:: true;
				fi
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:;
	c.closing!true;
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

