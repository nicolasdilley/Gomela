#define ThrottleWithOpts_opts_Limit  0
#define ThrottleWithOpts_opts_BacklogLimit  1

// /tmp/clone-example649036165/middleware/throttle.go
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
	int opts_Limit = ThrottleWithOpts_opts_Limit;
	Chandef t_tokens;
	int i;
	Chandef t_backlogTokens;
	int opts_BacklogLimit = ThrottleWithOpts_opts_BacklogLimit;
	bool state = false;
	
	if
	:: opts_Limit > 0 -> 
		t_tokens.size = opts_Limit;
		run AsyncChan(t_tokens)
	:: else -> 
		run sync_monitor(t_tokens)
	fi;
	
	if
	:: opts_Limit + opts_BacklogLimit > 0 -> 
		t_backlogTokens.size = opts_Limit + opts_BacklogLimit;
		run AsyncChan(t_backlogTokens)
	:: else -> 
		run sync_monitor(t_backlogTokens)
	fi;
	
	if
	:: 0 != -2 && opts_Limit + opts_BacklogLimit-1 != -3 -> 
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
