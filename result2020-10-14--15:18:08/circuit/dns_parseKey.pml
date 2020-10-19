#define lb_for198_0  -1
#define ub_for198_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example791829180/github.com/miekg/dns/kscan.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	int i;
	Chandef c;
	bool state = false;
	run sync_monitor(c);
	run go_dnsklexer(c);
	do
	:: c.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: c.async_rcv?0;
			:: c.sync?0;
			fi;
			

			if
			:: true;
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype go_dnsklexer(Chandef c) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for198_0 != -1 && ub_for198_1 != -1 -> 
				for(i : lb_for198_0.. ub_for198_1) {
for10:			

			if
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: c.async_send!0;
					:: c.sync!0 -> 
						c.sending?0
					fi
				fi
			:: true;
			:: true -> 
				
				if
				:: c.async_send!0;
				:: c.sync!0 -> 
					c.sending?0
				fi
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			

			if
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: c.async_send!0;
					:: c.sync!0 -> 
						c.sending?0
					fi
				fi
			:: true;
			:: true -> 
				
				if
				:: c.async_send!0;
				:: c.sync!0 -> 
					c.sending?0
				fi
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		
		if
		:: c.async_send!0;
		:: c.sync!0 -> 
			c.sending?0
		fi
	:: true;
	fi;
	c.closing!true;
stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

