#define lb_for562_0  -1
#define ub_for562_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example952928598/api/agent/drivers/docker/docker.go
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
	Chandef successChan;
	int i;
	Chandef stopSignal;
	bool state = false;
	run sync_monitor(successChan);
	
	if
	:: true -> 
		Chandef mon;
		run sync_monitor(mon);
		run Anonymous0(successChan,mon,stopSignal);
		do
		:: true;
		:: mon.async_rcv?0 -> 
			break
		:: mon.sync?0 -> 
			break
		od
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(stopSignal);
	run go_drvcollectStats(stopSignal);
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef successChan;Chandef mon;Chandef stopSignal) {
	bool closed; 
	int i;
	
	if
	:: successChan.async_rcv?0;
	:: successChan.sync?0;
	fi;
	
	if
	:: successChan.async_send!0;
	:: successChan.sync!0 -> 
		successChan.sending?0
	fi;
	mon.closing!true;
stop_process:
}
proctype go_drvcollectStats(Chandef stopSignal) {
	bool closed; 
	int i;
	Chandef dockerCallDone;
	Chandef dstats;
	run sync_monitor(dockerCallDone);
	
	if
	:: 1 > 0 -> 
		dstats.size = 1;
		run emptyChan(dstats)
	:: else -> 
		run sync_monitor(dstats)
	fi;
	run Anonymous2(dockerCallDone,dstats,stopSignal);
	do
	:: true -> 
for10:		do
		:: true -> 
			goto stop_process
		:: stopSignal.async_rcv?0 -> 
			goto stop_process
		:: stopSignal.sync?0 -> 
			goto stop_process
		od
	od;
for10_exit:	dockerCallDone.closing!true;
stop_process:
}
proctype Anonymous2(Chandef dockerCallDone;Chandef dstats;Chandef stopSignal) {
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

