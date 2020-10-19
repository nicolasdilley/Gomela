#define lb_for189_0  -1
#define ub_for189_1  -1
#define lb_for198_2  -1
#define ub_for198_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example193597720/conn_pool.go
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
	int i;
	
	if
	:: true -> 
		Chandef ch;
		
		if
		:: 5 > 0 -> 
			ch.size = 5;
			run emptyChan(ch)
		:: else -> 
			run sync_monitor(ch)
		fi;
		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi;
		run go_maincloseStaleServerConn(ch)
	:: true -> 
		chan child_mainputConnToChan1 = [0] of {int};
		run mainputConnToChan(ch,child_mainputConnToChan1);
		child_mainputConnToChan1?0
	:: true -> 
		chan child_mainputConnToChan1 = [0] of {int};
		run mainputConnToChan(ch,child_mainputConnToChan1);
		child_mainputConnToChan1?0
	fi
stop_process:}

proctype go_maincloseStaleServerConn(Chandef ch) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		chan child_maincloseServerConn0 = [0] of {int};
		run maincloseServerConn(ch,child_maincloseServerConn0);
		child_maincloseServerConn0?0;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for10_exit:	do
	:: true -> 
for20:		do
		:: ch.async_rcv?0 -> 
			break
		:: ch.sync?0 -> 
			break
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:stop_process:
}
proctype maincloseServerConn(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && lcnt-1 != -1 -> 
				for(i : 0.. lcnt-1) {
for11:			do
			:: ch.async_rcv?0 -> 
				
				if
				:: true -> 
					
					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				:: true -> 
					
					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				fi;
				break
			:: ch.sync?0 -> 
				
				if
				:: true -> 
					
					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				:: true -> 
					
					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				fi;
				break
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for11:			do
			:: ch.async_rcv?0 -> 
				
				if
				:: true -> 
					
					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				:: true -> 
					
					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				fi;
				break
			:: ch.sync?0 -> 
				
				if
				:: true -> 
					
					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				:: true -> 
					
					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				fi;
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for11_exit:	goto stop_process;
	child!0;
stop_process:
}
proctype mainputConnToChan(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: ch.async_send!0 -> 
		goto stop_process
	:: ch.sync!0 -> 
		ch.sending?0;
		goto stop_process
	:: true -> 
		break
	od;
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

