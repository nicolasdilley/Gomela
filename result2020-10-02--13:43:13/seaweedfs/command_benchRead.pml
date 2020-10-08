#define lb_for335_0  -1
#define ub_for335_1  -1
#define lb_for344_2  -1
#define ub_for344_3  -1
#define lb_for407_4  -1
#define ub_for407_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example417746801/weed/command/benchmark.go
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
	int b_idListFile = 5;
	Chandef fileIdLineChan;
	int i;
	Chandef finishChan;
	int b_concurrency = 5;
	bool state = false;
	run sync_monitor(fileIdLineChan);
	run sync_monitor(finishChan);
	run go_commandreadFileIds(fileIdLineChan);
	run go_readStatscheckProgress(finishChan);
		for(i : 0.. b_concurrency-1) {
for50:		run go_commandreadFiles(fileIdLineChan)
	};
for50_exit:	
	if
	:: finishChan.async_send!0;
	:: finishChan.sync!0 -> 
		finishChan.sending?0
	fi;
	finishChan.closing!true
stop_process:}

proctype go_commandreadFileIds(Chandef fileIdLineChan) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				
				if
				:: fileIdLineChan.async_send!0;
				:: fileIdLineChan.sync!0 -> 
					fileIdLineChan.sending?0
				fi
			:: true -> 
				break
			:: true -> 
				break
			fi
		od;
for10_exit:
	:: true -> 
		do
		:: true -> 
for20:			
			if
			:: true -> 
				break
			:: true -> 
				break
			fi
		od;
for20_exit:		
		if
		:: true -> 
			
			if
			:: 0 != -1 && readStats_total-1 != -1 -> 
								for(i : 0.. readStats_total-1) {
for30:					
					if
					:: fileIdLineChan.async_send!0;
					:: fileIdLineChan.sync!0 -> 
						fileIdLineChan.sending?0
					fi
				}
			:: else -> 
				do
				:: true -> 
for30:					
					if
					:: fileIdLineChan.async_send!0;
					:: fileIdLineChan.sync!0 -> 
						fileIdLineChan.sending?0
					fi
				:: true -> 
					break
				od
			fi;
for30_exit:
		:: true;
		fi
	:: true -> 
		do
		:: true -> 
for20:			
			if
			:: true -> 
				break
			:: true -> 
				break
			fi
		od;
for20_exit:		
		if
		:: true -> 
			
			if
			:: 0 != -1 && readStats_total-1 != -1 -> 
								for(i : 0.. readStats_total-1) {
for30:					
					if
					:: fileIdLineChan.async_send!0;
					:: fileIdLineChan.sync!0 -> 
						fileIdLineChan.sending?0
					fi
				}
			:: else -> 
				do
				:: true -> 
for30:					
					if
					:: fileIdLineChan.async_send!0;
					:: fileIdLineChan.sync!0 -> 
						fileIdLineChan.sending?0
					fi
				:: true -> 
					break
				od
			fi;
for30_exit:
		:: true;
		fi
	fi;
	fileIdLineChan.closing!true;
stop_process:
}
proctype go_readStatscheckProgress(Chandef finishChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for40:		do
		:: finishChan.async_rcv?0 -> 
			goto stop_process
		:: finishChan.sync?0 -> 
			goto stop_process
		od
	od;
for40_exit:stop_process:
}
proctype go_commandreadFiles(Chandef fileIdLineChan) {
	bool closed; 
	int i;
	do
	:: fileIdLineChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: fileIdLineChan.async_rcv?0;
			:: fileIdLineChan.sync?0;
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

