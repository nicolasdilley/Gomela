#define lb_for175_0  -1
#define ub_for175_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example591019498/ext/barcode/qr/encoder.go
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
	Chandef allPoints;
	Chandef result;
	int allPoints = 5;
	bool state = false;
	run sync_monitor(result);
	run sync_monitor(allPoints);
	run Anonymous0(result,allPoints);
	run Anonymous1(result,allPoints);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef result;Chandef allPoints) {
	bool closed; 
	int i;
	
	if
	:: lb_for175_0 != -1 && ub_for175_1 != -1 -> 
				for(i : lb_for175_0.. ub_for175_1) {
for10:			
			if
			:: true -> 
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true;
				fi
			:: true -> 
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true;
				fi
			:: true -> 
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true;
				fi
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true;
				fi
			:: true -> 
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true;
				fi
			:: true -> 
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true;
				fi
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	allPoints.closing!true;
stop_process:
}
proctype Anonymous1(Chandef result;Chandef allPoints) {
	bool closed; 
	int i;
	do
	:: allPoints.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			allPoints.in?0;
			
			if
			:: true -> 
				
				if
				:: result.async_send!0;
				:: result.sync!0 -> 
					result.sending?0
				fi
			:: true;
			fi
		fi
	od;
	result.closing!true;
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

