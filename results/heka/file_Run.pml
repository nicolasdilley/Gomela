#define lb_for330_0  -1
#define ub_for330_1  -1
#define lb_for255_2  -1
#define ub_for255_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example912192622/plugins/file/file_output.go
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
	chan child_oreceiver0 = [0] of {int};
	Chandef errChan;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		errChan.size = 1;
		run emptyChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	run go_ocommitter(errChan);
	run oreceiver(errChan,child_oreceiver0);
	child_oreceiver0?0;
	goto stop_process
stop_process:}

proctype go_ocommitter(Chandef errChan) {
	bool closed; 
	int i;
	Chandef hupChan;
	run sync_monitor(hupChan);
	
	if
	:: lb_for330_0 != -1 && ub_for330_1 != -1 -> 
				for(i : lb_for330_0.. ub_for330_1) {
for10:			do
			:: hupChan.async_rcv?0 -> 
				
				if
				:: true -> 
					
					if
					:: errChan.async_send!0;
					:: errChan.sync!0 -> 
						errChan.sending?0
					fi;
					break
				:: true;
				fi;
				break
			:: hupChan.sync?0 -> 
				
				if
				:: true -> 
					
					if
					:: errChan.async_send!0;
					:: errChan.sync!0 -> 
						errChan.sending?0
					fi;
					break
				:: true;
				fi;
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: hupChan.async_rcv?0 -> 
				
				if
				:: true -> 
					
					if
					:: errChan.async_send!0;
					:: errChan.sync!0 -> 
						errChan.sending?0
					fi;
					break
				:: true;
				fi;
				break
			:: hupChan.sync?0 -> 
				
				if
				:: true -> 
					
					if
					:: errChan.async_send!0;
					:: errChan.sync!0 -> 
						errChan.sending?0
					fi;
					break
				:: true;
				fi;
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:stop_process:
}
proctype oreceiver(Chandef errChan;chan child) {
	bool closed; 
	int i;
	
	if
	:: lb_for255_2 != -1 && ub_for255_3 != -1 -> 
				for(i : lb_for255_2.. ub_for255_3) {
for20:			do
			:: true;
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: true;
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process;
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

