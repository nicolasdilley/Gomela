
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
	Wgdef s_checkerWg;
	Chandef s_trackRenamesCh;
	Chandef s_srcFilesChan;
	bool state = false;
	Wgdef s_renamerWg;
	Chandef s_dstFilesResult;
	int fs_Config_Transfers = 5;
	Wgdef s_deletersWg;
	Wgdef s_transfersWg;
	Wgdef s_trackRenamesWg;
	Chandef s_srcFilesResult;
	Chandef s_deleteFilesCh;
	int fs_Config_Checkers = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(s_deletersWg);
	run wgMonitor(s_checkerWg);
	run wgMonitor(s_transfersWg);
	run wgMonitor(s_renamerWg);
	run wgMonitor(s_trackRenamesWg);
	
	if
	:: fs_Config_Checkers + fs_Config_Transfers > 0 -> 
		s_srcFilesChan.size = fs_Config_Checkers + fs_Config_Transfers;
		run emptyChan(s_srcFilesChan)
	:: else -> 
		run sync_monitor(s_srcFilesChan)
	fi;
	
	if
	:: 1 > 0 -> 
		s_srcFilesResult.size = 1;
		run emptyChan(s_srcFilesResult)
	:: else -> 
		run sync_monitor(s_srcFilesResult)
	fi;
	
	if
	:: 1 > 0 -> 
		s_dstFilesResult.size = 1;
		run emptyChan(s_dstFilesResult)
	:: else -> 
		run sync_monitor(s_dstFilesResult)
	fi;
	
	if
	:: fs_Config_Checkers > 0 -> 
		s_deleteFilesCh.size = fs_Config_Checkers;
		run emptyChan(s_deleteFilesCh)
	:: else -> 
		run sync_monitor(s_deleteFilesCh)
	fi;
	
	if
	:: fs_Config_Checkers > 0 -> 
		s_trackRenamesCh.size = fs_Config_Checkers;
		run emptyChan(s_trackRenamesCh)
	:: else -> 
		run sync_monitor(s_trackRenamesCh)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
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
	goto stop_process
stop_process:}

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

