#define lb_for911_0  -1
#define ub_for911_1  -1
#define lb_for919_2  -1
#define ub_for919_3  -1
#define lb_for941_4  -1
#define ub_for941_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example121482466/db.go
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
	Chandef pendingCh;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		pendingCh.size = 1;
		run emptyChan(pendingCh)
	:: else -> 
		run sync_monitor(pendingCh)
	fi;
		for(i : lb_for911_0.. ub_for911_1) {
for10:		do
		:: true -> 
			goto closedCase
		od;
		do
		:: true -> 
for11:			
			if
			:: true -> 
				
				if
				:: pendingCh.async_send!0;
				:: pendingCh.sync!0 -> 
					pendingCh.sending?0
				fi;
				goto writeCase
			:: true;
			fi;
			do
			:: pendingCh.async_send!0 -> 
				goto writeCase;
				break
			:: pendingCh.sync!0 -> 
				pendingCh.sending?0;
				goto writeCase;
				break
			:: true -> 
				goto closedCase
			od
		od;
for11_exit:closedCase:				do
		:: true -> 
for12:			do
			:: true -> 
				
				if
				:: pendingCh.async_send!0;
				:: pendingCh.sync!0 -> 
					pendingCh.sending?0
				fi;
				goto stop_process
			od
		od;
for12_exit:;
writeCase:		
	};
for10_exit:
stop_process:}

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

