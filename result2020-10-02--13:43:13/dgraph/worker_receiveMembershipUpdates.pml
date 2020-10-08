#define lb_for816_0  -1
#define ub_for816_1  -1
#define lb_for845_2  -1
#define ub_for845_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example076238862/worker/groups.go
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
	Chandef stateCh;
	bool state = false;
	int i;
START:		do
	:: true -> 
		goto stop_process
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		goto START
	:: true;
	fi;
	
	if
	:: true -> 
		goto START
	:: true;
	fi;
	
	if
	:: 10 > 0 -> 
		stateCh.size = 10;
		run emptyChan(stateCh)
	:: else -> 
		run sync_monitor(stateCh)
	fi;
	run Anonymous0(stateCh);
OUTER:		do
	:: true -> 
for20:		do
		:: true -> 
			goto OUTER
		:: true -> 
			goto OUTER
		:: true -> 
			
			if
			:: true -> 
				goto OUTER
			:: true;
			fi
		od
	od;
for20_exit:;
	goto START
stop_process:}

proctype Anonymous0(Chandef stateCh) {
	bool closed; 
	int i;
	
	if
	:: lb_for816_0 != -1 && ub_for816_1 != -1 -> 
				for(i : lb_for816_0.. ub_for816_1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: stateCh.async_send!0 -> 
				break
			:: stateCh.sync!0 -> 
				stateCh.sending?0;
				break
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: stateCh.async_send!0 -> 
				break
			:: stateCh.sync!0 -> 
				stateCh.sending?0;
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for10_exit:stop_process:
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

