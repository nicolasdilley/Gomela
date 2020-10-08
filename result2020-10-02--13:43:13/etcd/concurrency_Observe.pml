#define lb_for177_0  -1
#define ub_for177_1  -1
#define lb_for191_2  -1
#define ub_for191_3  -1
#define lb_for222_4  -1
#define ub_for222_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example152234228/clientv3/concurrency/election.go
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
	int i;
	Chandef retc;
	bool state = false;
	run sync_monitor(retc);
	run go_eobserve(retc);
	goto stop_process
stop_process:}

proctype go_eobserve(Chandef ch) {
	bool closed; 
	int i;
	do
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
			:: lb_for191_2 != -1 && ub_for191_3 != -1 -> 
								for(i : lb_for191_2.. ub_for191_3) {
for11:					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
										for(i : 1.. wr_Events) {
for12:						
						if
						:: true -> 
							break
						:: true;
						fi
					}
				}
			:: else -> 
				do
				:: true -> 
for11:					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
										for(i : 1.. wr_Events) {
for12:						
						if
						:: true -> 
							break
						:: true;
						fi
					}
				:: true -> 
					break
				od
			fi;
for11_exit:
		fi;
		do
		:: ch.async_send!0 -> 
			break
		:: ch.sync!0 -> 
			ch.sending?0;
			break
		:: true -> 
			goto stop_process
		od;
		
		if
		:: lb_for222_4 != -1 && ub_for222_5 != -1 -> 
						for(i : lb_for222_4.. ub_for222_5) {
for13:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
								for(i : 1.. wr_Events) {
for14:					
					if
					:: true -> 
						break
					:: true;
					fi;
					do
					:: ch.async_send!0 -> 
						break
					:: ch.sync!0 -> 
						ch.sending?0;
						break
					:: true -> 
						goto stop_process
					od
				}
			}
		:: else -> 
			do
			:: true -> 
for13:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
								for(i : 1.. wr_Events) {
for14:					
					if
					:: true -> 
						break
					:: true;
					fi;
					do
					:: ch.async_send!0 -> 
						break
					:: ch.sync!0 -> 
						ch.sending?0;
						break
					:: true -> 
						goto stop_process
					od
				}
			:: true -> 
				break
			od
		fi;
for13_exit:
	od;
for10_exit:	ch.closing!true;
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

