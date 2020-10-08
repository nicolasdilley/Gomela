#define lb_for45_0  -1
#define ub_for45_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example420044904/docker/stats.go
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
	Chandef stats;
	bool state = false;
	run sync_monitor(stats);
	run Anonymous0(stats);
	goto stop_process
stop_process:}

proctype dockernonBlockingSend(Chandef stats;chan child) {
	bool closed; 
	int i;
	do
	:: stats.async_send!0 -> 
		break
	:: stats.sync!0 -> 
		stats.sending?0;
		break
	:: true -> 
		break
	od;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef stats) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		chan child_dockernonBlockingSend0 = [0] of {int};
		run dockernonBlockingSend(stats,child_dockernonBlockingSend0);
		child_dockernonBlockingSend0?0;
		goto stop_process
	:: true;
	fi;
loop:		do
	:: true -> 
for10:		do
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					chan child_dockernonBlockingSend1 = [0] of {int};
					run dockernonBlockingSend(stats,child_dockernonBlockingSend1);
					child_dockernonBlockingSend1?0
				:: true -> 
					chan child_dockernonBlockingSend2 = [0] of {int};
					run dockernonBlockingSend(stats,child_dockernonBlockingSend2);
					child_dockernonBlockingSend2?0
				:: true -> 
					chan child_dockernonBlockingSend2 = [0] of {int};
					run dockernonBlockingSend(stats,child_dockernonBlockingSend2);
					child_dockernonBlockingSend2?0
				fi;
				goto loop
			:: true;
			fi;
			
			if
			:: true -> 
				chan child_dockernonBlockingSend3 = [0] of {int};
				run dockernonBlockingSend(stats,child_dockernonBlockingSend3);
				child_dockernonBlockingSend3?0;
				goto loop
			:: true;
			fi;
			chan child_dockernonBlockingSend4 = [0] of {int};
			run dockernonBlockingSend(stats,child_dockernonBlockingSend4);
			child_dockernonBlockingSend4?0;
			break
		:: true -> 
			goto loop
		od
	od;
for10_exit:;
	stats.closing!true;
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

