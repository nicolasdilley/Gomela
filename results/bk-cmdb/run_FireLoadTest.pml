#define lb_for51_0  -1
#define ub_for51_1  -1
#define lb_for63_2  -1
#define ub_for63_3  -1
#define lb_for80_4  -1
#define ub_for80_5  -1
#define lb_for94_6  -1
#define ub_for94_7  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example745197591/src/test/run/run.go
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
	Chandef ch;
	Chandef timeout;
	Chandef done;
	bool state = false;
	run sync_monitor(timeout);
	
	if
	:: true -> 
		run Anonymous0(timeout,ch,done)
	:: true;
	fi;
	
	if
	:: 3000 > 0 -> 
		ch.size = 3000;
		run emptyChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run sync_monitor(done);
	run Anonymous1(timeout,ch,done);
exitFor:			for(i : lb_for94_6.. ub_for94_7) {
for40:		do
		:: timeout.async_rcv?0 -> 
			goto exitFor;
			break
		:: timeout.sync?0 -> 
			goto exitFor;
			break
		:: true -> 
			chan child_limiterExecute0 = [0] of {int};
			run limiterExecute(ch,child_limiterExecute0);
			child_limiterExecute0?0;
			
			if
			:: true -> 
				timeout.closing!true
			:: true;
			fi;
			break
		od
	};
for40_exit:;
	
	if
	:: done.async_rcv?0;
	:: done.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef timeout;Chandef ch;Chandef done) {
	bool closed; 
	int i;
	do
	:: true -> 
		timeout.closing!true
	od;
stop_process:
}
proctype Anonymous1(Chandef timeout;Chandef ch;Chandef done) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: timeout.async_rcv?0 -> 
			goto outer;
			break
		:: timeout.sync?0 -> 
			goto outer;
			break
		od
	od;
for10_exit:outer:		
	if
	:: true -> 
		do
		:: true -> 
for20:			
			if
			:: true -> 
				
				if
				:: ch.async_rcv?0;
				:: ch.sync?0;
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi
		od;
for20_exit:		
		if
		:: done.async_send!0;
		:: done.sync!0 -> 
			done.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for30:		do
		:: true -> 
			
			if
			:: done.async_send!0;
			:: done.sync!0 -> 
				done.sending?0
			fi;
			goto stop_process
		od
	od;
for30_exit:	goto stop_process;
stop_process:
}
proctype limiterExecute(Chandef ch;chan child) {
	bool closed; 
	int i;
	run Anonymous3(ch);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous3(Chandef ch) {
	bool closed; 
	int i;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	goto stop_process;
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

