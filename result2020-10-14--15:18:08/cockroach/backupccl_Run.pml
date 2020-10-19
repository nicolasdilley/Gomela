#define Run_ssp_spec_Chunks  60
#define Run_numEntries  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example543475193/pkg/ccl/backupccl/split_and_scatter_processor.go
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
	int numEntries = Run_numEntries;
	Chandef doneScatterCh;
	bool state = false;
	int ssp_spec_Chunks = Run_ssp_spec_Chunks;
	int i;
		for(i : 1.. ssp_spec_Chunks) {
for10:
	};
	
	if
	:: numEntries > 0 -> 
		doneScatterCh.size = numEntries;
		run emptyChan(doneScatterCh)
	:: else -> 
		run sync_monitor(doneScatterCh)
	fi;
	run Anonymous0(doneScatterCh);
	do
	:: doneScatterCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: doneScatterCh.async_rcv?0;
			:: doneScatterCh.sync?0;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi
		fi
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi
stop_process:}

proctype backupcclrunSplitAndScatter(Chandef doneScatterCh;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef importSpanChunksCh;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(importSpanChunksCh);
	
	if
	:: 0 != -1 && splitScatterWorkers-1 != -1 -> 
				for(i : 0.. splitScatterWorkers-1) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef doneScatterCh) {
	bool closed; 
	int i;
	bool state;
	chan child_backupcclrunSplitAndScatter0 = [0] of {int};
	run backupcclrunSplitAndScatter(doneScatterCh,child_backupcclrunSplitAndScatter0);
	child_backupcclrunSplitAndScatter0?0;
	doneScatterCh.closing!true;
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

