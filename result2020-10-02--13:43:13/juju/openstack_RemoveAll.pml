
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example529324227/provider/openstack/storage.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Chandef toDelete;
	int maxRoutines = 5;
	Chandef errc;
	bool state = false;
	Wgdef wg;
	int names = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(toDelete);
	run Anonymous0(toDelete,errc,wg);
	run wgMonitor(wg);
	wg.Add!maxRoutines;
	
	if
	:: names > 0 -> 
		errc.size = names;
		run emptyChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
		for(i : 0.. maxRoutines-1) {
for20:		run Anonymous1(toDelete,errc,wg)
	};
for20_exit:	wg.Wait?0;
	do
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef toDelete;Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
		for(i : 1.. names) {
for10:		
		if
		:: toDelete.async_send!0;
		:: toDelete.sync!0 -> 
			toDelete.sending?0
		fi
	};
	toDelete.closing!true;
stop_process:
}
proctype Anonymous1(Chandef toDelete;Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: toDelete.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: toDelete.async_rcv?0;
			:: toDelete.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: errc.async_send!0;
				:: errc.sync!0 -> 
					errc.sending?0
				fi
			:: true;
			fi
		fi
	od;
	wg.Add!-1;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
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
