#define lsTreeBlobs_chanBufSize  0
#define ub_for115_1  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example289104344/lfs/gitscanner_tree.go
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
	chan child_lfsNewTreeBlobChannelWrapper0 = [0] of {int};
	Chandef errchan;
	Chandef blobs;
	int num_msgs = 0;
	bool state = false;
	int i;
	int chanBufSize = lsTreeBlobs_chanBufSize;
	

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
	run go_Anonymous0(blobs,errchan);
	run lfsNewTreeBlobChannelWrapper(blobs,errchan,child_lfsNewTreeBlobChannelWrapper0);
	child_lfsNewTreeBlobChannelWrapper0?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef blobs;Chandef errchan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && ub_for115_1 != -2 -> 
				for(i : 0.. ub_for115_1) {
			for10595: skip;
			

			if
			:: true -> 
				

				if
				:: blobs.async_send!0;
				:: blobs.sync!false,0 -> 
					blobs.sending?state
				fi
			:: true;
			fi;
			for10_end595: skip
		};
		for10_exit595: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: blobs.async_send!0;
				:: blobs.sync!false,0 -> 
					blobs.sending?state
				fi
			:: true;
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: true -> 
		

		if
		:: errchan.async_send!0;
		:: errchan.sync!false,0 -> 
			errchan.sending?state
		fi
	:: true;
	fi;
	blobs.closing!true;
	errchan.closing!true;
	stop_process: skip
}
proctype lfsNewTreeBlobChannelWrapper(Chandef treeBlobChan;Chandef errorChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

