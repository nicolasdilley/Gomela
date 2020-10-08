#define lb_for290_0  -1
#define ub_for290_1  -1
#define lb_for222_2  -1
#define ub_for222_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example131225776/command/exec/exec.go
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
	Chandef ackCh;
	Chandef doneCh;
	Chandef outputCh;
	int i;
	Chandef heartCh;
	Chandef exitCh;
	Chandef errCh;
	bool state = false;
	
	if
	:: 128 > 0 -> 
		ackCh.size = 128;
		run emptyChan(ackCh)
	:: else -> 
		run sync_monitor(ackCh)
	fi;
	
	if
	:: 128 > 0 -> 
		heartCh.size = 128;
		run emptyChan(heartCh)
	:: else -> 
		run sync_monitor(heartCh)
	fi;
	
	if
	:: 128 > 0 -> 
		outputCh.size = 128;
		run emptyChan(outputCh)
	:: else -> 
		run sync_monitor(outputCh)
	fi;
	
	if
	:: 128 > 0 -> 
		exitCh.size = 128;
		run emptyChan(exitCh)
	:: else -> 
		run sync_monitor(exitCh)
	fi;
	run sync_monitor(doneCh);
	
	if
	:: 1 > 0 -> 
		errCh.size = 1;
		run emptyChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
	run go_cstreamResults(doneCh,ackCh,heartCh,outputCh,exitCh,errCh);
OUTER:		do
	:: true -> 
for20:		do
		:: true -> 
			goto OUTER
		:: errCh.async_rcv?0 -> 
			goto stop_process
		:: errCh.sync?0 -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	doneCh.closing!true
stop_process:}

proctype go_cstreamResults(Chandef doneCh;Chandef ackCh;Chandef heartCh;Chandef outputCh;Chandef exitCh;Chandef errCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: doneCh.async_rcv?0 -> 
			goto stop_process
		:: doneCh.sync?0 -> 
			goto stop_process
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			goto ERR_EXIT
		:: true;
		fi;
				for(i : 1.. keys) {
for11:			

			if
			:: true;
			:: true -> 
				
				if
				:: ackCh.async_send!0;
				:: ackCh.sync!0 -> 
					ackCh.sending?0
				fi
			:: true -> 
				
				if
				:: exitCh.async_send!0;
				:: exitCh.sync!0 -> 
					exitCh.sending?0
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: heartCh.async_send!0;
					:: heartCh.sync!0 -> 
						heartCh.sending?0
					fi
				:: true -> 
					
					if
					:: outputCh.async_send!0;
					:: outputCh.sync!0 -> 
						outputCh.sending?0
					fi
				:: true -> 
					
					if
					:: outputCh.async_send!0;
					:: outputCh.sync!0 -> 
						outputCh.sending?0
					fi
				fi
			:: true;
			fi
		}
	od;
for10_exit:ERR_EXIT:		do
	:: errCh.async_send!0 -> 
		break
	:: errCh.sync!0 -> 
		errCh.sending?0;
		break
	:: true -> 
		break
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

