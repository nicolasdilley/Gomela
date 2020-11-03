#define ThrottleWithOpts_opts_Limit 3
#define ThrottleWithOpts_opts_BacklogLimit 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example387352094/middleware/throttle.go
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
	int opts_Limit = ThrottleWithOpts_opts_Limit;
	Chandef t_tokens;
	int i;
	Chandef t_backlogTokens;
	int opts_BacklogLimit = ThrottleWithOpts_opts_BacklogLimit;
	bool state = false;
	
	if
	:: opts_Limit > 0 -> 
		t_tokens.size = opts_Limit;
		run emptyChan(t_tokens)
	:: else -> 
		run sync_monitor(t_tokens)
	fi;
	
	if
	:: opts_Limit + opts_BacklogLimit > 0 -> 
		t_backlogTokens.size = opts_Limit + opts_BacklogLimit;
		run emptyChan(t_backlogTokens)
	:: else -> 
		run sync_monitor(t_backlogTokens)
	fi;
	
	if
	:: 0 != -1 && opts_Limit + opts_BacklogLimit-1 != -1 -> 
				for(i : 0.. opts_Limit + opts_BacklogLimit-1) {
for10:			
			if
			:: true -> 
				
				if
				:: t_tokens.async_send!0;
				:: t_tokens.sync!0 -> 
					t_tokens.sending?0
				fi
			:: true;
			fi;
			
			if
			:: t_backlogTokens.async_send!0;
			:: t_backlogTokens.sync!0 -> 
				t_backlogTokens.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				
				if
				:: t_tokens.async_send!0;
				:: t_tokens.sync!0 -> 
					t_tokens.sending?0
				fi
			:: true;
			fi;
			
			if
			:: t_backlogTokens.async_send!0;
			:: t_backlogTokens.sync!0 -> 
				t_backlogTokens.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

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


