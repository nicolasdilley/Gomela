#define Register_servers 1
#define lb_for588_1  -1
#define ub_for588_2  -1
#define lb_for102_3  -1
#define ub_for102_4  -1
#define lb_for206_5  -1
#define ub_for206_6  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example719734790/src/client/pkg/shard/sharder.go
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
	Chandef versionChan;
	int i;
	Chandef internalCancel;
	int servers = Register_servers;
	bool state = false;
	run sync_monitor(versionChan);
	run sync_monitor(internalCancel);
	run wgMonitor(wg);
	wg.Add!3;
	run Anonymous0(versionChan,internalCancel,wg);
	run Anonymous2(versionChan,internalCancel,wg);
	run Anonymous6(versionChan,internalCancel,wg);
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype aannounceServers(Chandef versionChan;Chandef cancel;chan child) {
	bool closed; 
	int i;
	bool state;
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
		:: versionChan.async_rcv?0 -> 
			break
		:: versionChan.sync?0 -> 
			break
		:: true;
		od
	od;
for10_exit:stop_process:	child!0
}
proctype Anonymous0(Chandef versionChan;Chandef internalCancel;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_aannounceServers0 = [0] of {int};
	run aannounceServers(versionChan,internalCancel,child_aannounceServers0);
	child_aannounceServers0?0;
stop_process:	wg.Add!-1
}
proctype afillRoles(Chandef versionChan;Chandef cancel;int servers;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_a_discoveryClientWatchAll2 = [0] of {int};
	run a_discoveryClientWatchAll(cancel,child_a_discoveryClientWatchAll1);
	child_a_discoveryClientWatchAll2?0;
	goto stop_process;
stop_process:	child!0
}
proctype a_discoveryClientWatchAll(Chandef cancel;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		chan child_cwatchAllWithoutRetry1 = [0] of {int};
		run cwatchAllWithoutRetry(cancel,child_cwatchAllWithoutRetry1);
		child_cwatchAllWithoutRetry1?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for20_exit:stop_process:	child!0
}
proctype cwatchAllWithoutRetry(Chandef cancel;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	fi;
	do
	:: true -> 
for21:		
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
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	od;
for21_exit:stop_process:	child!0
}
proctype Anonymous2(Chandef versionChan;Chandef internalCancel;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_afillRoles3 = [0] of {int};
	run afillRoles(versionChan,internalCancel,servers,child_afillRoles1);
	child_afillRoles3?0;
stop_process:	wg.Add!-1
}
proctype Anonymous6(Chandef versionChan;Chandef internalCancel;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: internalCancel.async_rcv?0;
	:: internalCancel.sync?0;
	fi;
stop_process:	wg.Add!-1
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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
	od
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


