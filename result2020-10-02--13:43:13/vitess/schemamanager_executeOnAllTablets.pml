
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example862180471/go/vt/schemamanager/tablet_executor.go
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
	Wgdef wg;
	int exec_tablets = 5;
	Chandef successChan;
	int i;
	Chandef errChan;
	int numOfMasterTablets = 5;
	int execResult_SuccessShards = 5;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!numOfMasterTablets;
	
	if
	:: numOfMasterTablets > 0 -> 
		errChan.size = numOfMasterTablets;
		run emptyChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	
	if
	:: numOfMasterTablets > 0 -> 
		successChan.size = numOfMasterTablets;
		run emptyChan(successChan)
	:: else -> 
		run sync_monitor(successChan)
	fi;
		for(i : 1.. exec_tablets) {
for10:		run Anonymous0(errChan,successChan,wg)
	};
	wg.Wait?0;
	errChan.closing!true;
	successChan.closing!true;
	do
	:: errChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: errChan.async_rcv?0;
			:: errChan.sync?0;
			fi
		fi
	od;
	do
	:: successChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: successChan.async_rcv?0;
			:: successChan.sync?0;
			fi
		fi
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. execResult_SuccessShards) {
for40:		wg.Add!1;
		run Anonymous2(errChan,successChan,wg)
	};
	wg.Wait?0
stop_process:}

proctype execexecuteOneTablet(Chandef errChan;Chandef successChan;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: errChan.async_send!0;
		:: errChan.sync!0 -> 
			errChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errChan.async_send!0;
		:: errChan.sync!0 -> 
			errChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: successChan.async_send!0;
	:: successChan.sync!0 -> 
		successChan.sending?0
	fi;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef errChan;Chandef successChan;Wgdef wg) {
	bool closed; 
	int i;
	chan child_execexecuteOneTablet0 = [0] of {int};
	run execexecuteOneTablet(errChan,successChan,child_execexecuteOneTablet0);
	child_execexecuteOneTablet0?0;
	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Chandef errChan;Chandef successChan;Wgdef wg) {
	bool closed; 
	int i;
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

