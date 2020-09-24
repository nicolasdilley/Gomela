#define lb_for75_0  -1
#define ub_for75_1  -1
#define lb_for71_2  -1
#define ub_for71_3  -1
#define lb_for85_4  -1
#define ub_for85_5  -1
#define lb_for56_6  -1
#define ub_for56_7  -1
#define lb_for66_8  -1
#define ub_for66_9  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example522284304/services/pull/lfs.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Chandef errChan;
	int i;
	Wgdef wg;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		errChan.size = 1;
		run emptyChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	run wgMonitor(wg);
	wg.Add!6;
	run go_pullcreateLFSMetaObjectsFromCatFileBatch(wg);
	run go_pipelineCatFileBatch(wg);
	run go_pipelineBlobsLessThan1024FromCatFileBatchCheck(wg);
	run go_pipelineCatFileBatchCheck(wg);
	run go_pipelineBlobsFromRevListObjects(wg);
	run go_pipelineRevListObjects(wg,errChan);
	wg.Wait?0;
	do
	:: true -> 
		break
	od;
	goto stop_process
stop_process:}

proctype go_pullcreateLFSMetaObjectsFromCatFileBatch(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for10_exit:	wg.Add!-1;
stop_process:
}
proctype go_pipelineCatFileBatch(Wgdef wg) {
	bool closed; 
	int i;
stop_process:
}
proctype go_pipelineBlobsLessThan1024FromCatFileBatchCheck(Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: lb_for71_2 != -1 && ub_for71_3 != -1 -> 
				for(i : lb_for71_2.. ub_for71_3) {
for20:			
			if
			:: lb_for85_4 != -1 && ub_for85_5 != -1 -> 
								for(i : lb_for85_4.. ub_for85_5) {
for21:					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for21:					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for21_exit:
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: lb_for85_4 != -1 && ub_for85_5 != -1 -> 
								for(i : lb_for85_4.. ub_for85_5) {
for21:					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for21:					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for21_exit:
		:: true -> 
			break
		od
	fi;
for20_exit:stop_process:
}
proctype go_pipelineCatFileBatchCheck(Wgdef wg) {
	bool closed; 
	int i;
stop_process:
}
proctype go_pipelineBlobsFromRevListObjects(Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: lb_for56_6 != -1 && ub_for56_7 != -1 -> 
				for(i : lb_for56_6.. ub_for56_7) {
for30:			
			if
			:: lb_for66_8 != -1 && ub_for66_9 != -1 -> 
								for(i : lb_for66_8.. ub_for66_9) {
for31:					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for31:					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for31_exit:
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: lb_for66_8 != -1 && ub_for66_9 != -1 -> 
								for(i : lb_for66_8.. ub_for66_9) {
for31:					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for31:					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for31_exit:
		:: true -> 
			break
		od
	fi;
for30_exit:stop_process:
}
proctype go_pipelineRevListObjects(Wgdef wg;Chandef errChan) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: errChan.async_send!0;
		:: errChan.sync!0 -> 
			errChan.sending?0
		fi
	:: true;
	fi;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
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

