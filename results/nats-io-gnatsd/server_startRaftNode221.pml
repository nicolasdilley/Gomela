#define startRaftNode_needed  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example766591707/server/raft.go
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
	Chandef n_applyc;
	Chandef n_stepdown;
	Chandef n_leadc;
	Chandef n_applyc;
	Chandef n_propc;
	Chandef n_resp;
	Chandef n_votes;
	Chandef n_reqs;
	Chandef n_quit;
	int num_msgs = 0;
	bool state = false;
	int i;
	int needed = startRaftNode_needed;
	

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
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(n_quit);
	

	if
	:: 4 > 0 -> 
		n_reqs.size = 4;
		run AsyncChan(n_reqs)
	:: else -> 
		run sync_monitor(n_reqs)
	fi;
	

	if
	:: 8 > 0 -> 
		n_votes.size = 8;
		run AsyncChan(n_votes)
	:: else -> 
		run sync_monitor(n_votes)
	fi;
	

	if
	:: 256 > 0 -> 
		n_resp.size = 256;
		run AsyncChan(n_resp)
	:: else -> 
		run sync_monitor(n_resp)
	fi;
	

	if
	:: 256 > 0 -> 
		n_propc.size = 256;
		run AsyncChan(n_propc)
	:: else -> 
		run sync_monitor(n_propc)
	fi;
	

	if
	:: 256 > 0 -> 
		n_applyc.size = 256;
		run AsyncChan(n_applyc)
	:: else -> 
		run sync_monitor(n_applyc)
	fi;
	

	if
	:: 4 > 0 -> 
		n_leadc.size = 4;
		run AsyncChan(n_leadc)
	:: else -> 
		run sync_monitor(n_leadc)
	fi;
	run sync_monitor(n_stepdown);
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: needed > 0 -> 
				n_applyc.size = needed;
				run AsyncChan(n_applyc)
			:: else -> 
				run sync_monitor(n_applyc)
			fi
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: n_applyc.async_send!0;
	:: n_applyc.sync!false,0 -> 
		n_applyc.sending?state
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
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

