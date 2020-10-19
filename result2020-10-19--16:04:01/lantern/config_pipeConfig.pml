#define lb_for96_0  -1
#define ub_for96_1  -1
#define lb_for187_2  -1
#define ub_for187_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example649711802/archive/src/github.com/getlantern/flashlight/config/config.go
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
	Chandef configChan;
	bool state = false;
	run sync_monitor(configChan);
	run Anonymous0(configChan);
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: configChan.async_send!0;
			:: configChan.sync!0 -> 
				configChan.sending?0
			fi
		:: true -> 
			
			if
			:: configChan.async_send!0;
			:: configChan.sync!0 -> 
				configChan.sending?0
			fi
		fi
	:: true -> 
		
		if
		:: configChan.async_send!0;
		:: configChan.sync!0 -> 
			configChan.sending?0
		fi
	:: true -> 
		
		if
		:: configChan.async_send!0;
		:: configChan.sync!0 -> 
			configChan.sending?0
		fi
	fi;
	run go_confpoll(configChan)
stop_process:}

proctype Anonymous0(Chandef configChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: configChan.async_rcv?0;
		:: configChan.sync?0;
		fi
	od;
for10_exit:stop_process:
}
proctype go_confpoll(Chandef configChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: configChan.async_send!0;
					:: configChan.sync!0 -> 
						configChan.sending?0
					fi
				:: true -> 
					
					if
					:: configChan.async_send!0;
					:: configChan.sync!0 -> 
						configChan.sending?0
					fi
				fi
			fi
		fi
	od;
for20_exit:stop_process:
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

