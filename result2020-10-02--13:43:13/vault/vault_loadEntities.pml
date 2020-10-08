#define lb_for207_0  -1
#define ub_for207_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example747669716/vault/identity_store_util.go
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
	int existing = 5;
	Chandef quit;
	bool state = false;
	Chandef result;
	int bucket_Items = 5;
	Chandef broker;
	Chandef errs;
	Wgdef wg;
	int consts_ExpirationRestoreWorkerCount = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(broker);
	run sync_monitor(quit);
	
	if
	:: existing > 0 -> 
		errs.size = existing;
		run emptyChan(errs)
	:: else -> 
		run sync_monitor(errs)
	fi;
	
	if
	:: existing > 0 -> 
		result.size = existing;
		run emptyChan(result)
	:: else -> 
		run sync_monitor(result)
	fi;
	run wgMonitor(wg);
		for(i : 0.. consts_ExpirationRestoreWorkerCount-1) {
for10:		wg.Add!1;
		run Anonymous0(broker,quit,errs,result)
	};
for10_exit:	wg.Add!1;
	run Anonymous1(broker,quit,errs,result);
	
	if
	:: 0 != -1 && existing-1 != -1 -> 
				for(i : 0.. existing-1) {
for30:			do
			od
		}
	:: else -> 
		do
		:: true -> 
for30:			do
			od
		:: true -> 
			break
		od
	fi;
for30_exit:	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef broker;Chandef quit;Chandef errs;Chandef result) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		do
		:: quit.async_rcv?0 -> 
			goto stop_process
		:: quit.sync?0 -> 
			goto stop_process
		od
	od;
for11_exit:stop_process:
}
proctype Anonymous1(Chandef broker;Chandef quit;Chandef errs;Chandef result) {
	bool closed; 
	int i;
		for(i : 1.. existing) {
for20:		do
		:: quit.async_rcv?0 -> 
			goto stop_process
		:: quit.sync?0 -> 
			goto stop_process
		:: true -> 
			
			if
			:: broker.async_send!0;
			:: broker.sync!0 -> 
				broker.sending?0
			fi;
			break
		od
	};
	broker.closing!true;
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

