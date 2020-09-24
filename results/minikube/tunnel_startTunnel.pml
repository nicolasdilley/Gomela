#define lb_for86_0  -1
#define ub_for86_1  -1
#define lb_for100_2  -1
#define ub_for100_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example641972900/pkg/minikube/tunnel/tunnel_manager.go
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
	Chandef check;
	Chandef ready;
	Chandef done;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		ready.size = 1;
		run emptyChan(ready)
	:: else -> 
		run sync_monitor(ready)
	fi;
	
	if
	:: 1 > 0 -> 
		check.size = 1;
		run emptyChan(check)
	:: else -> 
		run sync_monitor(check)
	fi;
	
	if
	:: 1 > 0 -> 
		done.size = 1;
		run emptyChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	run go_mgrtimerLoop(ready,check);
	run go_mgrrun(ready,check,done);
	goto stop_process
stop_process:}

proctype go_mgrtimerLoop(Chandef ready;Chandef check) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: ready.async_rcv?0;
		:: ready.sync?0;
		fi;
		
		if
		:: check.async_send!0;
		:: check.sync!0 -> 
			check.sending?0
		fi
	od;
for10_exit:stop_process:
}
proctype go_mgrrun(Chandef ready;Chandef check;Chandef done) {
	bool closed; 
	int i;
	
	if
	:: ready.async_send!0;
	:: ready.sync!0 -> 
		ready.sending?0
	fi;
	do
	:: true -> 
for20:		do
		:: true -> 
			goto stop_process
		:: check.async_rcv?0 -> 
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: ready.async_send!0;
			:: ready.sync!0 -> 
				ready.sending?0
			fi;
			break
		:: check.sync?0 -> 
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: ready.async_send!0;
			:: ready.sync!0 -> 
				ready.sending?0
			fi;
			break
		od
	od;
for20_exit:	
	if
	:: done.async_send!0;
	:: done.sync!0 -> 
		done.sending?0
	fi;
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

