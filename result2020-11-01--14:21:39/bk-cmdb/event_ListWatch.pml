#define ListWatch_types_DefaultEventChanSize 3
#define lb_for62_1  -1
#define ub_for62_2  -1
#define lb_for89_3  -1
#define ub_for89_4  -1
#define lb_for65_5  -1
#define ub_for65_6  -1
#define lb_for94_7  -1
#define ub_for94_8  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example589327031/src/storage/stream/event/list_watch.go
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
	int types_DefaultEventChanSize = ListWatch_types_DefaultEventChanSize;
	Chandef eventChan;
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
	:: types_DefaultEventChanSize > 0 -> 
		eventChan.size = types_DefaultEventChanSize;
		run emptyChan(eventChan)
	:: else -> 
		run sync_monitor(eventChan)
	fi;
	run Anonymous0(eventChan);
	goto stop_process
stop_process:}

proctype elister(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for62_1 != -1 && ub_for62_2 != -1 -> 
				for(i : lb_for62_1.. ub_for62_2) {
for10:			
			if
			:: true -> 
				do
				:: true -> 
for11:
				:: true -> 
					break
				od
			:: true;
			fi;
retry:			;
			
			if
			:: lb_for89_3 != -1 && ub_for89_4 != -1 -> 
								for(i : lb_for89_3.. ub_for89_4) {
for12:					do
					:: true -> 
						break
					od;
					
					if
					:: true -> 
						
						if
						:: true -> 
							ch.closing!true;
							goto stop_process
						:: true;
						fi;
						goto retry
					:: true;
					fi;
					
					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				}
			:: else -> 
				do
				:: true -> 
for12:					do
					:: true -> 
						break
					od;
					
					if
					:: true -> 
						
						if
						:: true -> 
							ch.closing!true;
							goto stop_process
						:: true;
						fi;
						goto retry
					:: true;
					fi;
					
					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				:: true -> 
					break
				od
			fi;
for12_exit:			
			if
			:: true -> 
				
				if
				:: true -> 
					ch.closing!true;
					goto stop_process
				:: true;
				fi;
				goto retry
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				do
				:: true -> 
for11:
				:: true -> 
					break
				od
			:: true;
			fi;
retry:			;
			
			if
			:: lb_for89_3 != -1 && ub_for89_4 != -1 -> 
								for(i : lb_for89_3.. ub_for89_4) {
for12:					do
					:: true -> 
						break
					od;
					
					if
					:: true -> 
						
						if
						:: true -> 
							ch.closing!true;
							goto stop_process
						:: true;
						fi;
						goto retry
					:: true;
					fi;
					
					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				}
			:: else -> 
				do
				:: true -> 
for12:					do
					:: true -> 
						break
					od;
					
					if
					:: true -> 
						
						if
						:: true -> 
							ch.closing!true;
							goto stop_process
						:: true;
						fi;
						goto retry
					:: true;
					fi;
					
					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				:: true -> 
					break
				od
			fi;
for12_exit:			
			if
			:: true -> 
				
				if
				:: true -> 
					ch.closing!true;
					goto stop_process
				:: true;
				fi;
				goto retry
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
stop_process:	child!0
}
proctype eloopWatch(Chandef eventChan;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		do
		:: true -> 
			break
		od;
		
		if
		:: lb_for94_7 != -1 && ub_for94_8 != -1 -> 
						for(i : lb_for94_7.. ub_for94_8) {
for21:				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: eventChan.async_send!0;
				:: eventChan.sync!0 -> 
					eventChan.sending?0
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
				fi;
				
				if
				:: eventChan.async_send!0;
				:: eventChan.sync!0 -> 
					eventChan.sending?0
				fi
			:: true -> 
				break
			od
		fi;
for21_exit:
	od;
for20_exit:stop_process:	child!0
}
proctype Anonymous0(Chandef eventChan) {
	bool closed; 
	int i;
	bool state;
	chan child_elister0 = [0] of {int};
	chan child_eloopWatch1 = [0] of {int};
	run elister(eventChan,child_elister0);
	child_elister0?0;
	do
	:: true -> 
		break
	od;
	run eloopWatch(eventChan,child_eloopWatch1);
	child_eloopWatch1?0;
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


