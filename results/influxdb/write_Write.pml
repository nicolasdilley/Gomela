#define lb_for104_0  -1
#define ub_for104_1  -1
#define lb_for69_2  -1
#define ub_for69_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example284558253/write/batcher.go
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
	Chandef errC;
	Chandef lines;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(lines);
	
	if
	:: 2 > 0 -> 
		errC.size = 2;
		run emptyChan(errC)
	:: else -> 
		run sync_monitor(errC)
	fi;
	run go_bwrite(lines,errC);
	run go_bread(lines,errC);
	
	if
	:: 0 != -1 && 2-1 != -1 -> 
				for(i : 0.. 2-1) {
for30:			do
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for30:			do
			:: true -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

proctype go_bwrite(Chandef lines;Chandef errC) {
	bool closed; 
	int i;
	
	if
	:: lb_for104_0 != -1 && ub_for104_1 != -1 -> 
				for(i : lb_for104_0.. ub_for104_1) {
for10:			do
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						
						if
						:: errC.async_send!0;
						:: errC.sync!0 -> 
							errC.sending?0
						fi;
						goto stop_process
					:: true;
					fi
				:: true;
				fi
			:: true -> 
				
				if
				:: errC.async_send!0;
				:: errC.sync!0 -> 
					errC.sending?0
				fi;
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						
						if
						:: errC.async_send!0;
						:: errC.sync!0 -> 
							errC.sending?0
						fi;
						goto stop_process
					:: true;
					fi
				:: true;
				fi
			:: true -> 
				
				if
				:: errC.async_send!0;
				:: errC.sync!0 -> 
					errC.sending?0
				fi;
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: errC.async_send!0;
	:: errC.sync!0 -> 
		errC.sending?0
	fi;
stop_process:
}
proctype go_bread(Chandef lines;Chandef errC) {
	bool closed; 
	int i;
	
	if
	:: lb_for69_2 != -1 && ub_for69_3 != -1 -> 
				for(i : lb_for69_2.. ub_for69_3) {
for20:			do
			:: lines.async_send!0 -> 
				break
			:: lines.sync!0 -> 
				lines.sending?0;
				break
			:: true -> 
				
				if
				:: errC.async_send!0;
				:: errC.sync!0 -> 
					errC.sending?0
				fi;
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: lines.async_send!0 -> 
				break
			:: lines.sync!0 -> 
				lines.sending?0;
				break
			:: true -> 
				
				if
				:: errC.async_send!0;
				:: errC.sync!0 -> 
					errC.sending?0
				fi;
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: errC.async_send!0;
	:: errC.sync!0 -> 
		errC.sending?0
	fi;
	lines.closing!true;
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

