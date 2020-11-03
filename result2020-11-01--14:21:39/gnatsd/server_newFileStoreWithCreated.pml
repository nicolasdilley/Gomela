#define lb_for1315_0  -1
#define ub_for1315_1  -1
#define lb_for1325_2  -1
#define ub_for1325_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example213061294/server/filestore.go
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
	Chandef sch;
	Chandef fs_fch;
	bool state = false;
	Chandef fs_qch;
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
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		fs_fch.size = 1;
		run emptyChan(fs_fch)
	:: else -> 
		run sync_monitor(fs_fch)
	fi;
	run sync_monitor(fs_qch);
	
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
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run sync_monitor(sch);
	run go_fsflushLoop(fs_fch,fs_qch,sch);
	
	if
	:: sch.async_rcv?0;
	:: sch.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype go_fsflushLoop(Chandef fch;Chandef qch;Chandef sch) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		sch.closing!true
	:: true;
	fi;
	do
	:: true -> 
for10:		do
		:: fch.async_rcv?0 -> 
			
			if
			:: lb_for1325_2 != -1 && ub_for1325_3 != -1 -> 
								for(i : lb_for1325_2.. ub_for1325_3) {
for11:					
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
					do
					:: qch.async_rcv?0 -> 
						goto stop_process
					:: qch.sync?0 -> 
						goto stop_process
					:: true -> 
						break
					od
				}
			:: else -> 
				do
				:: true -> 
for11:					
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
					do
					:: qch.async_rcv?0 -> 
						goto stop_process
					:: qch.sync?0 -> 
						goto stop_process
					:: true -> 
						break
					od
				:: true -> 
					break
				od
			fi;
for11_exit:			break
		:: fch.sync?0 -> 
			
			if
			:: lb_for1325_2 != -1 && ub_for1325_3 != -1 -> 
								for(i : lb_for1325_2.. ub_for1325_3) {
for11:					
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
					do
					:: qch.async_rcv?0 -> 
						goto stop_process
					:: qch.sync?0 -> 
						goto stop_process
					:: true -> 
						break
					od
				}
			:: else -> 
				do
				:: true -> 
for11:					
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
					do
					:: qch.async_rcv?0 -> 
						goto stop_process
					:: qch.sync?0 -> 
						goto stop_process
					:: true -> 
						break
					od
				:: true -> 
					break
				od
			fi;
for11_exit:			break
		:: qch.async_rcv?0 -> 
			goto stop_process
		:: qch.sync?0 -> 
			goto stop_process
		od
	od;
for10_exit:stop_process:
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

