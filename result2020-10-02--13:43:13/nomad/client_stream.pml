#define lb_for676_0  -1
#define ub_for676_1  -1
#define lb_for714_2  -1
#define ub_for714_3  -1
#define lb_for271_4  -1
#define ub_for271_5  -1
#define lb_for289_6  -1
#define ub_for289_7  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example190109984/client/fs_endpoint.go
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
	bool state = false;
	Chandef errCh;
	Chandef frames;
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
		goto stop_process
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
	:: true;
	:: true;
	:: true -> 
		goto stop_process
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
	:: 32 > 0 -> 
		frames.size = 32;
		run emptyChan(frames)
	:: else -> 
		run sync_monitor(frames)
	fi;
	run sync_monitor(errCh);
	
	if
	:: true -> 
		Chandef eofCancelCh;
		run sync_monitor(eofCancelCh);
		eofCancelCh.closing!true
	:: true;
	fi;
	run Anonymous0(frames,errCh,eofCancelCh);
	run Anonymous2(frames,errCh,eofCancelCh);
OUTER:		do
	:: true -> 
for30:		do
		:: true -> 
			goto OUTER
		od
	od;
for30_exit:;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi
stop_process:}

proctype fstreamFile(Chandef eofCancelCh;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
OUTER:		do
	:: true -> 
for10:		
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
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		do
		:: true -> 
for11:			do
			:: true;
			:: true -> 
				goto stop_process
			:: true -> 
				
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
				fi
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			od
		od;
for11_exit:
	od;
for10_exit:;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef frames;Chandef errCh;Chandef eofCancelCh) {
	bool closed; 
	int i;
	chan child_fstreamFile0 = [0] of {int};
	run fstreamFile(eofCancelCh,child_fstreamFile0);
	child_fstreamFile0?0;
	
	if
	:: true -> 
		do
		:: errCh.async_send!0 -> 
			break
		:: errCh.sync!0 -> 
			errCh.sending?0;
			break
		:: true;
		od
	:: true;
	fi;
stop_process:
}
proctype Anonymous2(Chandef frames;Chandef errCh;Chandef eofCancelCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: errCh.async_send!0 -> 
				break
			:: errCh.sync!0 -> 
				errCh.sending?0;
				break
			:: true -> 
				goto stop_process
			od
		:: true;
		fi
	od;
for20_exit:stop_process:
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

