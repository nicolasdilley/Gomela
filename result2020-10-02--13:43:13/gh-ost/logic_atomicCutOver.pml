
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example949170883/go/logic/migrator.go
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
	Chandef okToUnlockTable;
	Chandef renameSessionIdChan;
	Chandef tableLocked;
	int i;
	Chandef lockOriginalSessionIdChan;
	Chandef tableUnlocked;
	Chandef tablesRenamed;
	bool state = false;
	
	if
	:: 4 > 0 -> 
		okToUnlockTable.size = 4;
		run emptyChan(okToUnlockTable)
	:: else -> 
		run sync_monitor(okToUnlockTable)
	fi;
	
	if
	:: 2 > 0 -> 
		lockOriginalSessionIdChan.size = 2;
		run emptyChan(lockOriginalSessionIdChan)
	:: else -> 
		run sync_monitor(lockOriginalSessionIdChan)
	fi;
	
	if
	:: 2 > 0 -> 
		tableLocked.size = 2;
		run emptyChan(tableLocked)
	:: else -> 
		run sync_monitor(tableLocked)
	fi;
	
	if
	:: 2 > 0 -> 
		tableUnlocked.size = 2;
		run emptyChan(tableUnlocked)
	:: else -> 
		run sync_monitor(tableUnlocked)
	fi;
	run Anonymous0(okToUnlockTable,lockOriginalSessionIdChan,tableLocked,tableUnlocked,renameSessionIdChan,tablesRenamed);
	
	if
	:: tableLocked.async_rcv?0;
	:: tableLocked.sync?0;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lockOriginalSessionIdChan.async_rcv?0;
	:: lockOriginalSessionIdChan.sync?0;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 2 > 0 -> 
		renameSessionIdChan.size = 2;
		run emptyChan(renameSessionIdChan)
	:: else -> 
		run sync_monitor(renameSessionIdChan)
	fi;
	
	if
	:: 2 > 0 -> 
		tablesRenamed.size = 2;
		run emptyChan(tablesRenamed)
	:: else -> 
		run sync_monitor(tablesRenamed)
	fi;
	run Anonymous2(okToUnlockTable,lockOriginalSessionIdChan,tableLocked,tableUnlocked,renameSessionIdChan,tablesRenamed);
	
	if
	:: renameSessionIdChan.async_rcv?0;
	:: renameSessionIdChan.sync?0;
	fi;
	
	if
	:: true -> 
		
		if
		:: okToUnlockTable.async_send!0;
		:: okToUnlockTable.sync!0 -> 
			okToUnlockTable.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: okToUnlockTable.async_send!0;
	:: okToUnlockTable.sync!0 -> 
		okToUnlockTable.sending?0
	fi;
	
	if
	:: tableUnlocked.async_rcv?0;
	:: tableUnlocked.sync?0;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: tablesRenamed.async_rcv?0;
	:: tablesRenamed.sync?0;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	
	if
	:: okToUnlockTable.async_send!0;
	:: okToUnlockTable.sync!0 -> 
		okToUnlockTable.sending?0
	fi
stop_process:}

proctype this_applierAtomicCutOverMagicLock(Chandef sessionIdChan;Chandef tableLocked;Chandef okToUnlockTable;Chandef tableUnlocked;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: tableLocked.async_send!0;
		:: tableLocked.sync!0 -> 
			tableLocked.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: tableLocked.async_send!0;
		:: tableLocked.sync!0 -> 
			tableLocked.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: sessionIdChan.async_send!0;
	:: sessionIdChan.sync!0 -> 
		sessionIdChan.sending?0
	fi;
	
	if
	:: true -> 
		
		if
		:: tableLocked.async_send!0;
		:: tableLocked.sync!0 -> 
			tableLocked.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: tableLocked.async_send!0;
		:: tableLocked.sync!0 -> 
			tableLocked.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: tableLocked.async_send!0;
		:: tableLocked.sync!0 -> 
			tableLocked.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: tableLocked.async_send!0;
		:: tableLocked.sync!0 -> 
			tableLocked.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: tableLocked.async_send!0;
	:: tableLocked.sync!0 -> 
		tableLocked.sending?0
	fi;
	
	if
	:: okToUnlockTable.async_rcv?0;
	:: okToUnlockTable.sync?0;
	fi;
	
	if
	:: true -> 
		
		if
		:: tableUnlocked.async_send!0;
		:: tableUnlocked.sync!0 -> 
			tableUnlocked.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: tableUnlocked.async_send!0;
	:: tableUnlocked.sync!0 -> 
		tableUnlocked.sending?0
	fi;
	goto stop_process;
	
	if
	:: sessionIdChan.async_send!0;
	:: sessionIdChan.sync!0 -> 
		sessionIdChan.sending?0
	fi;
	
	if
	:: tableLocked.async_send!0;
	:: tableLocked.sync!0 -> 
		tableLocked.sending?0
	fi;
	
	if
	:: tableUnlocked.async_send!0;
	:: tableUnlocked.sync!0 -> 
		tableUnlocked.sending?0
	fi;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef okToUnlockTable;Chandef lockOriginalSessionIdChan;Chandef tableLocked;Chandef tableUnlocked;Chandef renameSessionIdChan;Chandef tablesRenamed) {
	bool closed; 
	int i;
	chan child_this_applierAtomicCutOverMagicLock0 = [0] of {int};
	run this_applierAtomicCutOverMagicLock(lockOriginalSessionIdChan,tableLocked,okToUnlockTable,tableUnlocked,child_this_applierAtomicCutOverMagicLock0);
	child_this_applierAtomicCutOverMagicLock0?0;
stop_process:
}
proctype this_applierAtomicCutoverRename(Chandef sessionIdChan;Chandef tablesRenamed;chan child) {
	bool closed; 
	int i;
	
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
	:: sessionIdChan.async_send!0;
	:: sessionIdChan.sync!0 -> 
		sessionIdChan.sending?0
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: tablesRenamed.async_send!0;
		:: tablesRenamed.sync!0 -> 
			tablesRenamed.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: tablesRenamed.async_send!0;
	:: tablesRenamed.sync!0 -> 
		tablesRenamed.sending?0
	fi;
	goto stop_process;
	
	if
	:: sessionIdChan.async_send!0;
	:: sessionIdChan.sync!0 -> 
		sessionIdChan.sending?0
	fi;
	
	if
	:: tablesRenamed.async_send!0;
	:: tablesRenamed.sync!0 -> 
		tablesRenamed.sending?0
	fi;
	child!0;
stop_process:
}
proctype Anonymous2(Chandef okToUnlockTable;Chandef lockOriginalSessionIdChan;Chandef tableLocked;Chandef tableUnlocked;Chandef renameSessionIdChan;Chandef tablesRenamed) {
	bool closed; 
	int i;
	chan child_this_applierAtomicCutoverRename1 = [0] of {int};
	run this_applierAtomicCutoverRename(renameSessionIdChan,tablesRenamed,child_this_applierAtomicCutoverRename1);
	child_this_applierAtomicCutoverRename1?0;
	
	if
	:: true -> 
		
		if
		:: okToUnlockTable.async_send!0;
		:: okToUnlockTable.sync!0 -> 
			okToUnlockTable.sending?0
		fi
	:: true;
	fi;
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

