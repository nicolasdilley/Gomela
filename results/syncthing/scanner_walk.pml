#define lb_for168_0  -1
#define ub_for168_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example919684116/lib/scanner/walk.go
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
	Chandef toHashChan;
	int toHashChan = 5;
	int w_Subs = 5;
	int i;
	Chandef finishedChan;
	int w_Hashers = 5;
	int filesToHash = 5;
	bool state = false;
	run sync_monitor(toHashChan);
	run sync_monitor(finishedChan);
	run Anonymous0(toHashChan,finishedChan);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous2(toHashChan,finishedChan);
	goto stop_process
stop_process:}

proctype wwalkAndHashFiles(Chandef toHashChan;Chandef finishedChan;chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef toHashChan;Chandef finishedChan) {
	bool closed; 
	int i;
	chan child_wwalkAndHashFiles0 = [0] of {int};
	run wwalkAndHashFiles(toHashChan,finishedChan,child_wwalkAndHashFiles0);
	child_wwalkAndHashFiles0?0;
	
	if
	:: true -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	:: true -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
	toHashChan.closing!true;
stop_process:
}
proctype scannernewParallelHasher(Chandef outbox;Chandef inbox;Chandef done;int workers;chan child) {
	bool closed; 
	int i;
		for(i : 0.. workers-1) {
for30:
	};
for30_exit:	child!0;
stop_process:
}
proctype Anonymous3(Chandef toHashChan;Chandef finishedChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for40:		do
		:: true -> 
			goto stop_process
		:: true;
		:: true -> 
			goto stop_process
		od
	od;
for40_exit:stop_process:
}
proctype Anonymous2(Chandef toHashChan;Chandef finishedChan) {
	bool closed; 
	int i;
	Chandef realToHashChan;
	chan child_scannernewParallelHasher1 = [0] of {int};
	Chandef done;
	do
	:: toHashChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			toHashChan.in?0
		fi
	od;
	run sync_monitor(realToHashChan);
	run sync_monitor(done);
	run scannernewParallelHasher(finishedChan,realToHashChan,done,w_Hashers,child_scannernewParallelHasher1);
	child_scannernewParallelHasher1?0;
	run Anonymous3(toHashChan,finishedChan);
loop:		do
	:: true -> 
for50:		do
		:: realToHashChan.async_send!0 -> 
			break
		:: realToHashChan.sync!0 -> 
			realToHashChan.sending?0;
			break
		:: true -> 
			goto loop
		od
	:: true -> 
		break
	od;
	realToHashChan.closing!true;
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

