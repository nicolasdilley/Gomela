
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example000609524/lib/model/folder_recvenc.go
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
	chan child_deleteDirOnDisk0 = [0] of {int};
	chan child_deleteDirOnDisk0 = [0] of {int};
	Chandef scanChan;
	bool state = false;
	int i;
	int dirs = -2;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(scanChan);
	run go_pullScannerRoutine(scanChan);
	

	if
	:: dirs-1 != -3 -> 
				for(i : 0.. dirs-1) {
			for30: skip;
			run deleteDirOnDisk(scanChan,child_deleteDirOnDisk0);
			child_deleteDirOnDisk0?0;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for30123: skip;
			run deleteDirOnDisk(scanChan,child_deleteDirOnDisk0);
			child_deleteDirOnDisk0?0;
			for30_end123: skip
		:: true -> 
			break
		od;
		for30_exit123: skip
	fi;
	scanChan.closing!true
stop_process:skip
}

proctype go_pullScannerRoutine(Chandef scanChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: scanChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: scanChan.async_rcv?0;
			:: scanChan.sync?0;
			fi;
			for10: skip;
			for10_end: skip
		fi
	od;
	for10_exit: skip;
	stop_process: skip
}
proctype deleteDirOnDisk(Chandef scanChan;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_deleteDirOnDiskHandleChildren0 = [0] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run deleteDirOnDiskHandleChildren(scanChan,child_deleteDirOnDiskHandleChildren0);
	child_deleteDirOnDiskHandleChildren0?0;
	

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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype deleteDirOnDiskHandleChildren(Chandef scanChan;chan child) {
	bool closed; 
	int i;
	bool state;
	

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
		:: scanChan.async_send!0;
		:: scanChan.sync!0 -> 
			scanChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
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

