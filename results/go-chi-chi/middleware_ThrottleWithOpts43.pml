#define ThrottleWithOpts_opts_Limit  0
#define ThrottleWithOpts_opts_BacklogLimit  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example614618123/middleware/throttle.go
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
	Chandef t_backlogTokens;
	Chandef t_tokens;
	int num_msgs = 0;
	bool state = false;
	int i;
	int opts_BacklogLimit = ThrottleWithOpts_opts_BacklogLimit;
	int opts_Limit = ThrottleWithOpts_opts_Limit;
	

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
			for10835: skip;
			

			if
			:: true -> 
				

				if
				:: t_tokens.async_send!0;
				:: t_tokens.sync!false,0 -> 
					t_tokens.sending?state
				fi
			:: true;
			fi;
			

			if
			:: t_backlogTokens.async_send!0;
			:: t_backlogTokens.sync!false,0 -> 
				t_backlogTokens.sending?state
			fi;
			for10_end835: skip
		};
		for10_exit835: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: t_tokens.async_send!0;
				:: t_tokens.sync!false,0 -> 
					t_tokens.sending?state
				fi
			:: true;
			fi;
			

			if
			:: t_backlogTokens.async_send!0;
			:: t_backlogTokens.sync!false,0 -> 
				t_backlogTokens.sending?state
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	goto stop_process
stop_process:skip
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

