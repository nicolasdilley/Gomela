#define lb_for122_0  -1
#define ub_for122_1  -1
#define lb_for81_2  -1
#define ub_for81_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example856946014/web/web.go
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
	Chandef wevs;
	bool state = false;
	run sync_monitor(wevs);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0(wevs)
stop_process:}

proctype webwalk(Chandef ch;chan child) {
	bool closed; 
	int i;
	
	if
	:: lb_for122_0 != -1 && ub_for122_1 != -1 -> 
				for(i : lb_for122_0.. ub_for122_1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for20:		chan child_webwalk0 = [0] of {int};
		run webwalk(ch,child_webwalk0);
		child_webwalk0?0
	:: true -> 
		break
	od;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef wevs) {
	bool closed; 
	int i;
	chan child_webwalk1 = [0] of {int};
	run webwalk(wevs,child_webwalk0);
	child_webwalk1?0;
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
			break
		:: true;
		fi;
		
		if
		:: wevs.async_send!0;
		:: wevs.sync!0 -> 
			wevs.sending?0
		fi
	od;
for30_exit:	wevs.closing!true;
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
