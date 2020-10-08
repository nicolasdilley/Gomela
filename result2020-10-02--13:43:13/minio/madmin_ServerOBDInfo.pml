#define lb_for297_0  -1
#define ub_for297_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example079818199/pkg/madmin/obd.go
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
	Chandef respChan;
	int i;
	int OBDDataTypesList = 5;
	bool state = false;
	run sync_monitor(respChan);
	run Anonymous0(respChan);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef respChan) {
	bool closed; 
	int i;
		for(i : 1.. OBDDataTypesList) {
for10:
	};
		for(i : 1.. obdDataTypes) {
for20:
	};
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: respChan.async_send!0;
			:: respChan.sync!0 -> 
				respChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: respChan.async_send!0;
		:: respChan.sync!0 -> 
			respChan.sending?0
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: respChan.async_send!0;
		:: respChan.sync!0 -> 
			respChan.sending?0
		fi;
		respChan.closing!true;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: respChan.async_send!0;
		:: respChan.sync!0 -> 
			respChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for30:		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: respChan.async_send!0;
			:: respChan.sync!0 -> 
				respChan.sending?0
			fi
		:: true;
		fi;
		
		if
		:: respChan.async_send!0;
		:: respChan.sync!0 -> 
			respChan.sending?0
		fi
	od;
for30_exit:	
	if
	:: respChan.async_send!0;
	:: respChan.sync!0 -> 
		respChan.sending?0
	fi;
	respChan.closing!true;
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

