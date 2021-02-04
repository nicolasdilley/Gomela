#define ProcessBackupRequest_state_Groups  3
#define ProcessBackupRequest_groups  3

// https://github.com/dgraph-io/dgraph/blob/ee0b99586ab740fbdec6da78605624c7feba2e5d/worker/backup_ee.go#L96
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
	Chandef resCh;
	int num_msgs = 0;
	bool state = false;
	int i;
	int groups = ProcessBackupRequest_groups;
	int state_Groups = ProcessBackupRequest_state_Groups;
	

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
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: state_Groups > 0 -> 
		resCh.size = state_Groups;
		run AsyncChan(resCh)
	:: else -> 
		run sync_monitor(resCh)
	fi;
		for(i : 0.. groups-1) {
		for20: skip;
		run go_Anonymous0(resCh);
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: groups-1 != -3 -> 
				for(i : 0.. groups-1) {
			for30: skip;
			

			if
			:: resCh.async_rcv?state,num_msgs;
			:: resCh.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			fi;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for30587: skip;
			

			if
			:: resCh.async_rcv?state,num_msgs;
			:: resCh.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			fi;
			for30_end587: skip
		:: true -> 
			break
		od;
		for30_exit587: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef resCh) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: resCh.async_send!0;
	:: resCh.sync!false,0 -> 
		resCh.sending?state
	fi;
	stop_process: skip
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

