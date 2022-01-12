// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/go-chi/chi/blob//middleware/throttle.go#L43
#define def_var_opts_Limit53  ?? // mand opts.Limit line 53
#define def_var_opts_BacklogLimit54  ?? // mand opts.BacklogLimit line 54
typedef Chandef {
	chan sync = [0] of {bool};
	chan enq = [0] of {int};
	chan deq = [0] of {bool,int};
	chan sending = [0] of {bool};
	chan rcving = [0] of {bool};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	chan child_ThrottleWithOpts430 = [1] of {int};
	run ThrottleWithOpts43(child_ThrottleWithOpts430);
	run receiver(child_ThrottleWithOpts430)
stop_process:skip
}

proctype ThrottleWithOpts43(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef t_backlogTokens_ch;
	Chandef t_tokens_ch;
	int var_opts_BacklogLimit = def_var_opts_BacklogLimit54; // mand var_opts_BacklogLimit
	int var_opts_Limit = def_var_opts_Limit53; // mand var_opts_Limit
	

	if
	:: var_opts_Limit > 0 -> 
		t_tokens_ch.size = var_opts_Limit;
		run AsyncChan(t_tokens_ch)
	:: else -> 
		run sync_monitor(t_tokens_ch)
	fi;
	

	if
	:: var_opts_Limit+var_opts_BacklogLimit > 0 -> 
		t_backlogTokens_ch.size = var_opts_Limit+var_opts_BacklogLimit;
		run AsyncChan(t_backlogTokens_ch)
	:: else -> 
		run sync_monitor(t_backlogTokens_ch)
	fi;
	

	if
	:: 0 != -2 && var_opts_Limit+var_opts_BacklogLimit-1 != -3 -> 
				for(i : 0.. var_opts_Limit+var_opts_BacklogLimit-1) {
			for11: skip;
			

			if
			:: true -> 
				

				if
				:: t_tokens_ch.enq!0;
				:: t_tokens_ch.sync!false -> 
					t_tokens_ch.sending!false
				fi
			:: true;
			fi;
			

			if
			:: t_backlogTokens_ch.enq!0;
			:: t_backlogTokens_ch.sync!false -> 
				t_backlogTokens_ch.sending!false
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: t_tokens_ch.enq!0;
				:: t_tokens_ch.sync!false -> 
					t_tokens_ch.sending!false
				fi
			:: true;
			fi;
			

			if
			:: t_backlogTokens_ch.enq!0;
			:: t_backlogTokens_ch.sync!false -> 
				t_backlogTokens_ch.sending!false
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
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
  :: ch.num_msgs > 0 -> // cannot send on closed channel
    end4: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.deq!true,ch.num_msgs -> 
  		 ch.num_msgs = ch.num_msgs - 1
    fi;
  :: else ->    end5: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.sync!true; 
    fi;
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.deq!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		    ch.closed = true
		   :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.enq?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.rcving?false ->
 		    ch.sending?false;
		fi;
		:: else -> 
		end3: if
		  :: ch.enq?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.deq!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		     ch.closed = true
		  :: ch.rcving?false ->
 		    ch.sending?false;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.rcving?false;
  :: ch.sync!true; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.rcving?false ->
       ch.sending?false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

proctype receiver(chan c) {
c?0
}

