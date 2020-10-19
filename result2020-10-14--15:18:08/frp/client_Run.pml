#define Run_sv_readCh  60
#define lb_for57_1  -1
#define ub_for57_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example923212683/client/visitor.go
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
	int sv_readCh = Run_sv_readCh;
	Chandef sv_sendCh;
	bool state = false;
	Chandef sv_readCh;
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
	:: 1024 > 0 -> 
		sv_sendCh.size = 1024;
		run emptyChan(sv_sendCh)
	:: else -> 
		run sync_monitor(sv_sendCh)
	fi;
	
	if
	:: 1024 > 0 -> 
		sv_readCh.size = 1024;
		run emptyChan(sv_readCh)
	:: else -> 
		run sync_monitor(sv_readCh)
	fi;
	run go_udpForwardUserConn(sv_readCh,sv_sendCh,sv_readCh);
	goto stop_process
stop_process:}

proctype go_udpForwardUserConn(Chandef readCh;Chandef sendCh;int readCh) {
	bool closed; 
	int i;
	bool state;
	run Anonymous1(readCh,sendCh);
	do
	:: true -> 
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: sendCh.async_send!0 -> 
			break
		:: sendCh.sync!0 -> 
			sendCh.sending?0;
			break
		:: true -> 
			break
		od
	od;
for20_exit:stop_process:
}
proctype Anonymous1(Chandef readCh;Chandef sendCh) {
	bool closed; 
	int i;
	bool state;
	do
	:: readCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: readCh.async_rcv?0;
			:: readCh.sync?0;
			fi
		fi
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

