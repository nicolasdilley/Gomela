
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example312108606/api.go
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
	Chandef r_leadershipTransferCh;
	Chandef r_bootstrapCh;
	Chandef r_configurationsCh;
	Chandef r_verifyCh;
	Chandef r_shutdownCh;
	Chandef r_userRestoreCh;
	Chandef r_userSnapshotCh;
	Chandef r_configurationChangeCh;
	Chandef r_leaderCh;
	Chandef r_fsmSnapshotCh;
	Chandef r_fsmMutateCh;
	Chandef r_applyCh;
	bool state = false;
	int i;
	

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
	run sync_monitor(r_applyCh);
	

	if
	:: 128 > 0 -> 
		r_fsmMutateCh.size = 128;
		run AsyncChan(r_fsmMutateCh)
	:: else -> 
		run sync_monitor(r_fsmMutateCh)
	fi;
	run sync_monitor(r_fsmSnapshotCh);
	

	if
	:: 1 > 0 -> 
		r_leaderCh.size = 1;
		run AsyncChan(r_leaderCh)
	:: else -> 
		run sync_monitor(r_leaderCh)
	fi;
	run sync_monitor(r_configurationChangeCh);
	run sync_monitor(r_userSnapshotCh);
	run sync_monitor(r_userRestoreCh);
	run sync_monitor(r_shutdownCh);
	

	if
	:: 64 > 0 -> 
		r_verifyCh.size = 64;
		run AsyncChan(r_verifyCh)
	:: else -> 
		run sync_monitor(r_verifyCh)
	fi;
	

	if
	:: 8 > 0 -> 
		r_configurationsCh.size = 8;
		run AsyncChan(r_configurationsCh)
	:: else -> 
		run sync_monitor(r_configurationsCh)
	fi;
	run sync_monitor(r_bootstrapCh);
	

	if
	:: 1 > 0 -> 
		r_leadershipTransferCh.size = 1;
		run AsyncChan(r_leadershipTransferCh)
	:: else -> 
		run sync_monitor(r_leadershipTransferCh)
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
	goto stop_process
stop_process:skip
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

