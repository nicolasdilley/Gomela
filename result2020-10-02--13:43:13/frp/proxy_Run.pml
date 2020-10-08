#define lb_for166_0  -1
#define ub_for166_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example588783230/server/proxy/udp.go
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
	Chandef pxy_checkCloseCh;
	Chandef pxy_sendCh;
	bool state = false;
	Chandef pxy_readCh;
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
	:: 1024 > 0 -> 
		pxy_sendCh.size = 1024;
		run emptyChan(pxy_sendCh)
	:: else -> 
		run sync_monitor(pxy_sendCh)
	fi;
	
	if
	:: 1024 > 0 -> 
		pxy_readCh.size = 1024;
		run emptyChan(pxy_readCh)
	:: else -> 
		run sync_monitor(pxy_readCh)
	fi;
	run sync_monitor(pxy_checkCloseCh);
	run Anonymous0(pxy_sendCh,pxy_readCh,pxy_checkCloseCh);
	run Anonymous1(pxy_sendCh,pxy_readCh,pxy_checkCloseCh);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef pxy_sendCh;Chandef pxy_readCh;Chandef pxy_checkCloseCh) {
	bool closed; 
	int i;
		for(i : lb_for166_0.. ub_for166_1) {
for10:		
		if
		:: true -> 
			do
			:: true -> 
				break
			od
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
for10_exit:stop_process:
}
proctype Anonymous1(Chandef pxy_sendCh;Chandef pxy_readCh;Chandef pxy_checkCloseCh) {
	bool closed; 
	int i;
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

