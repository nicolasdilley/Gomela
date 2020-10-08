#define lb_for671_0  -1
#define ub_for671_1  -1
#define lb_for584_2  -1
#define ub_for584_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example050395616/service/s3/s3manager/upload.go
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
	int u_cfg_Concurrency = 5;
	Chandef ch;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: u_cfg_Concurrency > 0 -> 
		ch.size = u_cfg_Concurrency;
		run emptyChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
		for(i : 0.. u_cfg_Concurrency-1) {
for10:		run go_ureadChunk(ch)
	};
for10_exit:	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	
	if
	:: lb_for584_2 != -1 && ub_for584_3 != -1 -> 
				for(i : lb_for584_2.. ub_for584_3) {
for20:			
			if
			:: true -> 
				break
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
for20:			
			if
			:: true -> 
				break
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
for20_exit:	ch.closing!true;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype go_ureadChunk(Chandef ch) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		
		if
		:: ch.async_rcv?0;
		:: ch.sync?0;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for11_exit:stop_process:
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

