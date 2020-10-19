
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example581771142/go/datas/http_chunk_store.go
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
	Chandef chunkChan;
	int i;
	chan child_datasbuildWriteValueRequest4 = [0] of {int};
	bool state = false;
	
	if
	:: 1024 > 0 -> 
		chunkChan.size = 1024;
		run emptyChan(chunkChan)
	:: else -> 
		run sync_monitor(chunkChan)
	fi;
	run Anonymous0(chunkChan);
	run datasbuildWriteValueRequest(chunkChan,child_datasbuildWriteValueRequest4);
	child_datasbuildWriteValueRequest4?0
stop_process:}

proctype pExtractChunks(Chandef chunkChan;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_nbc_chunksextractChunks2 = [0] of {int};
	run nbc_chunksextractChunks(chunkChan,child_nbc_chunksextractChunks0);
	child_nbc_chunksextractChunks2?0;
	child!0;
stop_process:
}
proctype nbc_chunksextractChunks(Chandef chunkChan;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef ch;
	
	if
	:: 1 > 0 -> 
		ch.size = 1;
		run emptyChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run Anonymous2(ch,chunkChan);
	do
	:: ch.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: ch.async_rcv?0;
			:: ch.sync?0;
			fi;
			
			if
			:: chunkChan.async_send!0;
			:: chunkChan.sync!0 -> 
				chunkChan.sending?0
			fi
		fi
	od;
	child!0;
stop_process:
}
proctype nbs_tablesextract(Chandef chunks;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: chunks.async_send!0;
		:: chunks.sync!0 -> 
			chunks.sending?0
		fi
	:: true -> 
		break
	od;
	goto stop_process;
	child!0;
stop_process:
}
proctype nbs_mtextract(Chandef chunks;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		
		if
		:: chunks.async_send!0;
		:: chunks.sync!0 -> 
			chunks.sending?0
		fi
	:: true -> 
		break
	od;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous2(Chandef ch;Chandef chunkChan) {
	bool closed; 
	int i;
	bool state;
	chan child_nbs_tablesextract0 = [0] of {int};
	run nbs_tablesextract(ch,child_nbs_tablesextract0);
	child_nbs_tablesextract0?0;
	
	if
	:: true -> 
		chan child_nbs_mtextract1 = [0] of {int};
		run nbs_mtextract(ch,child_nbs_mtextract1);
		child_nbs_mtextract1?0
	:: true;
	fi;
	ch.closing!true;
stop_process:
}
proctype Anonymous0(Chandef chunkChan) {
	bool closed; 
	int i;
	bool state;
	chan child_pExtractChunks3 = [0] of {int};
	run pExtractChunks(chunkChan,child_pExtractChunks0);
	child_pExtractChunks3?0;
	chunkChan.closing!true;
stop_process:
}
proctype datasbuildWriteValueRequest(Chandef chunkChan;chan child) {
	bool closed; 
	int i;
	bool state;
	run Anonymous7(chunkChan);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous7(Chandef chunkChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: chunkChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: chunkChan.async_rcv?0;
			:: chunkChan.sync?0;
			fi
		fi
	od;
stop_process:
}
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

