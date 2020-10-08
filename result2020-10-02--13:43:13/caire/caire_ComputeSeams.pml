
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example033152346/carver.go
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
	int usedSeams = 5;
	int c_Height = 5;
	int faces = 5;
	bool state = false;
	int seam_ActiveSeam = 5;
	int c_Width = 5;
	int i;
		for(i : 1.. usedSeams) {
for10:				for(i : 1.. seam_ActiveSeam) {
for11:
		}
	};
	
	if
	:: true -> 
				for(i : 1.. faces) {
for20:
		};
		Chandef c;
		
		if
		:: 2 > 0 -> 
			c.size = 2;
			run emptyChan(c)
		:: else -> 
			run sync_monitor(c)
		fi;
		run Anonymous0(c)
	:: true;
	fi;
	
	if
	:: 0 != -1 && c_Width-1 != -1 -> 
				for(i : 0.. c_Width-1) {
for40:			
			if
			:: 0 != -1 && c_Height-1 != -1 -> 
								for(i : 0.. c_Height-1) {
for41:
				}
			:: else -> 
				do
				:: true -> 
for41:
				:: true -> 
					break
				od
			fi;
for41_exit:
		}
	:: else -> 
		do
		:: true -> 
for40:			
			if
			:: 0 != -1 && c_Height-1 != -1 -> 
								for(i : 0.. c_Height-1) {
for41:
				}
			:: else -> 
				do
				:: true -> 
for41:
				:: true -> 
					break
				od
			fi;
for41_exit:
		:: true -> 
			break
		od
	fi;
for40_exit:	
	if
	:: 1 != -1 && c_Height-1 != -1 -> 
				for(i : 1.. c_Height-1) {
for50:			
			if
			:: 1 != -1 && c_Width - 1-1 != -1 -> 
								for(i : 1.. c_Width - 1-1) {
for51:
				}
			:: else -> 
				do
				:: true -> 
for51:
				:: true -> 
					break
				od
			fi;
for51_exit:
		}
	:: else -> 
		do
		:: true -> 
for50:			
			if
			:: 1 != -1 && c_Width - 1-1 != -1 -> 
								for(i : 1.. c_Width - 1-1) {
for51:
				}
			:: else -> 
				do
				:: true -> 
for51:
				:: true -> 
					break
				od
			fi;
for51_exit:
		:: true -> 
			break
		od
	fi;
for50_exit:
stop_process:}

proctype Anonymous0(Chandef c) {
	bool closed; 
	int i;
	do
	:: c.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: c.async_rcv?0;
			:: c.sync?0;
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

