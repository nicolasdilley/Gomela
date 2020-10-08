#define lb_for170_0  -1
#define ub_for170_1  -1
#define lb_for187_2  -1
#define ub_for187_3  -1
#define lb_for48_4  -1
#define ub_for48_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example942100504/test/e2e_node/services/server.go
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
	chan child_servicesreadinessCheck0 = [0] of {int};
	Chandef errCh;
	int s_healthCheckUrls = 5;
	bool state = false;
	run sync_monitor(errCh);
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		Chandef stopRestartingCh;
		run sync_monitor(stopRestartingCh);
		Chandef ackStopRestartingCh;
		run sync_monitor(ackStopRestartingCh)
	:: true;
	fi;
	run Anonymous0(errCh,stopRestartingCh,ackStopRestartingCh);
	run servicesreadinessCheck(errCh,s_healthCheckUrls,child_servicesreadinessCheck0);
	child_servicesreadinessCheck0?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errCh;Chandef stopRestartingCh;Chandef ackStopRestartingCh) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: errCh.async_send!0;
		:: errCh.sync!0 -> 
			errCh.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: errCh.async_send!0;
			:: errCh.sync!0 -> 
				errCh.sending?0
			fi;
			goto stop_process
		:: true -> 
			
			if
			:: errCh.async_send!0;
			:: errCh.sync!0 -> 
				errCh.sending?0
			fi;
			goto stop_process
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errCh.async_send!0;
		:: errCh.sync!0 -> 
			errCh.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: errCh.async_send!0;
			:: errCh.sync!0 -> 
				errCh.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	:: true -> 
		do
		:: true -> 
for10:stillAlive:						do
			:: true -> 
for11:				do
				:: stopRestartingCh.async_rcv?0 -> 
					
					if
					:: ackStopRestartingCh.async_send!0;
					:: ackStopRestartingCh.sync!0 -> 
						ackStopRestartingCh.sending?0
					fi;
					goto stop_process
				:: stopRestartingCh.sync?0 -> 
					
					if
					:: ackStopRestartingCh.async_send!0;
					:: ackStopRestartingCh.sync!0 -> 
						ackStopRestartingCh.sending?0
					fi;
					goto stop_process
				:: true -> 
										for(i : 1.. s_healthCheckUrls) {
for12:						
						if
						:: true -> 
							goto stillAlive
						:: true;
						fi
					}
				od
			od;
for11_exit:
		od;
for10_exit:
	:: true -> 
		do
		:: true -> 
for10:stillAlive:						do
			:: true -> 
for11:				do
				:: stopRestartingCh.async_rcv?0 -> 
					
					if
					:: ackStopRestartingCh.async_send!0;
					:: ackStopRestartingCh.sync!0 -> 
						ackStopRestartingCh.sending?0
					fi;
					goto stop_process
				:: stopRestartingCh.sync?0 -> 
					
					if
					:: ackStopRestartingCh.async_send!0;
					:: ackStopRestartingCh.sync!0 -> 
						ackStopRestartingCh.sending?0
					fi;
					goto stop_process
				:: true -> 
										for(i : 1.. s_healthCheckUrls) {
for12:						
						if
						:: true -> 
							goto stillAlive
						:: true;
						fi
					}
				od
			od;
for11_exit:
		od;
for10_exit:
	fi;
	errCh.closing!true;
stop_process:
}
proctype servicesreadinessCheck(Chandef errCh;int urls;chan child) {
	bool closed; 
	int i;
	Chandef blockCh;
	run sync_monitor(blockCh);
	
	if
	:: lb_for48_4 != -1 && ub_for48_5 != -1 -> 
				for(i : lb_for48_4.. ub_for48_5) {
for20:			do
			:: true -> 
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
				od;
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: true -> 
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
				od;
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process;
	blockCh.closing!true;
	child!0;
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

