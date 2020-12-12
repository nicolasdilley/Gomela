#define lsTreeBlobs_chanBufSize  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example714267106/lfs/gitscanner_tree.go
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
	Chandef errchan;
	bool state = false;
	int chanBufSize = lsTreeBlobs_chanBufSize;
	Chandef blobs;
	chan child_lfsNewTreeBlobChannelWrapper0 = [0] of {int};
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: chanBufSize > 0 -> 
		blobs.size = chanBufSize;
		run AsyncChan(blobs)
	:: else -> 
		run sync_monitor(blobs)
	fi;
	
	if
	:: 1 > 0 -> 
		errchan.size = 1;
		run AsyncChan(errchan)
	:: else -> 
		run sync_monitor(errchan)
	fi;
	run Anonymous0(blobs,errchan);
	run lfsNewTreeBlobChannelWrapper(blobs,errchan,child_lfsNewTreeBlobChannelWrapper0);
	child_lfsNewTreeBlobChannelWrapper0?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef blobs;Chandef errchan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for115_1 != -2 && ub_for115_2 != -2 -> 
				for(i : lb_for115_1.. ub_for115_2) {
for10:			
			if
			:: true -> 
				
				if
				:: blobs.async_send!0;
				:: blobs.sync!0 -> 
					blobs.sending?0
				fi
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				
				if
				:: blobs.async_send!0;
				:: blobs.sync!0 -> 
					blobs.sending?0
				fi
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		
		if
		:: errchan.async_send!0;
		:: errchan.sync!0 -> 
			errchan.sending?0
		fi
	:: true;
	fi;
	blobs.closing!true;
	errchan.closing!true;
stop_process:
}
proctype lfsNewTreeBlobChannelWrapper(Chandef treeBlobChan;Chandef errorChan;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
stop_process:	child!0
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

