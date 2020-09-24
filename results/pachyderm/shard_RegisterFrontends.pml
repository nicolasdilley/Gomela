#define lb_for616_0  -1
#define ub_for616_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example816561999/src/client/pkg/shard/sharder.go
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
	int i;
	Chandef internalCancel;
	Chandef versionChan;
	Wgdef wg;
	bool state = false;
	run sync_monitor(versionChan);
	run sync_monitor(internalCancel);
	run wgMonitor(wg);
	wg.Add!3;
	run Anonymous0(versionChan,internalCancel,wg);
	run Anonymous2(versionChan,internalCancel,wg);
	run Anonymous4(versionChan,internalCancel,wg);
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype aannounceFrontends(Chandef versionChan;Chandef cancel;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: cancel.async_rcv?0 -> 
			goto stop_process
		:: cancel.sync?0 -> 
			goto stop_process
		:: true;
		od
	od;
for10_exit:	child!0;
stop_process:
}
proctype Anonymous0(Chandef versionChan;Chandef internalCancel;Wgdef wg) {
	bool closed; 
	int i;
	chan child_aannounceFrontends0 = [0] of {int};
	run aannounceFrontends(versionChan,internalCancel,child_aannounceFrontends0);
	child_aannounceFrontends0?0;
	wg.Add!-1;
stop_process:
}
proctype arunFrontends(Chandef versionChan;Chandef cancel;int frontends;chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous2(Chandef versionChan;Chandef internalCancel;Wgdef wg) {
	bool closed; 
	int i;
	chan child_arunFrontends1 = [0] of {int};
	run arunFrontends(versionChan,internalCancel,frontends,child_arunFrontends1);
	child_arunFrontends1?0;
	wg.Add!-1;
stop_process:
}
proctype Anonymous4(Chandef versionChan;Chandef internalCancel;Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: internalCancel.async_rcv?0;
	:: internalCancel.sync?0;
	fi;
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

