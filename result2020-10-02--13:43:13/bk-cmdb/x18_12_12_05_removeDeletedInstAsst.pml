
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example245838319/src/scene_server/admin_server/upgrader/x18.12.12.05/remove_deleted_inst_asst.go
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
	Chandef errChan;
	Chandef instAsstQueue;
	int i;
	Chandef asstNameChan;
	int assts = 5;
	bool state = false;
	
	if
	:: 1000 > 0 -> 
		instAsstQueue.size = 1000;
		run emptyChan(instAsstQueue)
	:: else -> 
		run sync_monitor(instAsstQueue)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: assts > 0 -> 
		asstNameChan.size = assts;
		run emptyChan(asstNameChan)
	:: else -> 
		run sync_monitor(asstNameChan)
	fi;
		for(i : 1.. assts) {
for10:		
		if
		:: asstNameChan.async_send!0;
		:: asstNameChan.sync!0 -> 
			asstNameChan.sending?0
		fi
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1000 > 0 -> 
		errChan.size = 1000;
		run emptyChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	run Anonymous0(instAsstQueue,asstNameChan,errChan);
	do
	:: true;
	od;
	run Anonymous1(instAsstQueue,asstNameChan,errChan);
	do
	:: true;
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef instAsstQueue;Chandef asstNameChan;Chandef errChan) {
	bool closed; 
	int i;
		for(i : 1.. timer_C) {
for20:		
		if
		:: true -> 
			asstNameChan.closing!true;
			break
		:: true;
		fi
	};
stop_process:
}
proctype Anonymous1(Chandef instAsstQueue;Chandef asstNameChan;Chandef errChan) {
	bool closed; 
	int i;
		for(i : 1.. timer_C) {
for30:		
		if
		:: true -> 
			instAsstQueue.closing!true;
			break
		:: true;
		fi
	};
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

