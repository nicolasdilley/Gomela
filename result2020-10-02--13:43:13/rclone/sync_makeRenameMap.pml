
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example822197482/fs/sync/sync.go
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
	bool state = false;
	int fs_Config_Checkers = 5;
	Wgdef wg;
	int fs_Config_Transfers = 5;
	Chandef in;
	int s_renameCheck = 5;
	int s_dstFiles = 5;
	int i;
		for(i : 1.. s_renameCheck) {
for10:
	};
	
	if
	:: fs_Config_Checkers > 0 -> 
		in.size = fs_Config_Checkers;
		run emptyChan(in)
	:: else -> 
		run sync_monitor(in)
	fi;
	run go_spumpMapToChan(in,s_dstFiles);
	run wgMonitor(wg);
	wg.Add!fs_Config_Transfers;
		for(i : 0.. fs_Config_Transfers-1) {
for30:		run Anonymous1(in,wg)
	};
for30_exit:	wg.Wait?0
stop_process:}

proctype go_spumpMapToChan(Chandef out;int files) {
	bool closed; 
	int i;
outer:			for(i : 1.. files) {
for20:		
		if
		:: true -> 
			goto outer
		:: true;
		fi;
		do
		:: out.async_send!0 -> 
			break
		:: out.sync!0 -> 
			out.sending?0;
			break
		:: true -> 
			goto outer
		od
	};
	out.closing!true;
stop_process:
}
proctype Anonymous1(Chandef in;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: in.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: in.async_rcv?0;
			:: in.sync?0;
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

