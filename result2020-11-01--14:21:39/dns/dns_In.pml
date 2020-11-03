#define inIxfr_in_Answer 3
#define ub_for79_1  -1
#define inIxfr_in_Answer  ??
#define lb_for130_3  -1
#define ub_for130_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example527519412/xfr.go
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
	Chandef env;
	bool state = false;
	int i;
	

	if
	:: true;
	:: true -> 
		goto stop_process
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(env);
	

	if
	:: true -> 
		run go_tinAxfr(env)
	:: true -> 
		run go_tinIxfr(env)
	fi;
	goto stop_process
stop_process:}

proctype go_tinAxfr(Chandef c) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: c.async_send!0;
			:: c.sync!0 -> 
				c.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: c.async_send!0;
			:: c.sync!0 -> 
				c.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: c.async_send!0;
				:: c.sync!0 -> 
					c.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: c.async_send!0;
				:: c.sync!0 -> 
					c.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: c.async_send!0;
				:: c.sync!0 -> 
					c.sending?0
				fi
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: c.async_send!0;
				:: c.sync!0 -> 
					c.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: c.async_send!0;
			:: c.sync!0 -> 
				c.sending?0
			fi
		:: true;
		fi
	od;
for10_exit:stop_process:	c.closing!true
}
proctype go_tinIxfr(Chandef c) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			
			if
			:: c.async_send!0;
			:: c.sync!0 -> 
				c.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: c.async_send!0;
			:: c.sync!0 -> 
				c.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: c.async_send!0;
			:: c.sync!0 -> 
				c.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: c.async_send!0;
				:: c.sync!0 -> 
					c.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: c.async_send!0;
				:: c.sync!0 -> 
					c.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
				for(i : 0.. in_Answer-1) {
for21:			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						
						if
						:: c.async_send!0;
						:: c.sync!0 -> 
							c.sending?0
						fi;
						goto stop_process
					:: true;
					fi
				fi
			:: true;
			fi
		};
		
		if
		:: c.async_send!0;
		:: c.sync!0 -> 
			c.sending?0
		fi
	od;
for20_exit:stop_process:	c.closing!true
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


