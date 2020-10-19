
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example437804699/store/sqlstore/supplier.go
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
	int i;
	Chandef results;
	bool state = false;
	run sync_monitor(results);
	run go_sqlstoreCheckRelationalIntegrity(results);
	goto stop_process
stop_process:}

proctype go_sqlstoreCheckRelationalIntegrity(Chandef results) {
	bool closed; 
	int i;
	bool state;
	chan child_sqlstorecheckCommandsIntegrity1 = [0] of {int};
	chan child_sqlstorecheckTeamsIntegrity5 = [0] of {int};
	chan child_sqlstorecheckSchemesIntegrity3 = [0] of {int};
	chan child_sqlstorecheckChannelsIntegrity0 = [0] of {int};
	chan child_sqlstorecheckPostsIntegrity2 = [0] of {int};
	chan child_sqlstorecheckSessionsIntegrity4 = [0] of {int};
	chan child_sqlstorecheckUsersIntegrity6 = [0] of {int};
	run sqlstorecheckChannelsIntegrity(results,child_sqlstorecheckChannelsIntegrity0);
	child_sqlstorecheckChannelsIntegrity0?0;
	run sqlstorecheckCommandsIntegrity(results,child_sqlstorecheckCommandsIntegrity1);
	child_sqlstorecheckCommandsIntegrity1?0;
	run sqlstorecheckPostsIntegrity(results,child_sqlstorecheckPostsIntegrity2);
	child_sqlstorecheckPostsIntegrity2?0;
	run sqlstorecheckSchemesIntegrity(results,child_sqlstorecheckSchemesIntegrity3);
	child_sqlstorecheckSchemesIntegrity3?0;
	run sqlstorecheckSessionsIntegrity(results,child_sqlstorecheckSessionsIntegrity4);
	child_sqlstorecheckSessionsIntegrity4?0;
	run sqlstorecheckTeamsIntegrity(results,child_sqlstorecheckTeamsIntegrity5);
	child_sqlstorecheckTeamsIntegrity5?0;
	run sqlstorecheckUsersIntegrity(results,child_sqlstorecheckUsersIntegrity6);
	child_sqlstorecheckUsersIntegrity6?0;
	results.closing!true;
stop_process:
}
proctype sqlstorecheckChannelsIntegrity(Chandef results;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	child!0;
stop_process:
}
proctype sqlstorecheckCommandsIntegrity(Chandef results;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	child!0;
stop_process:
}
proctype sqlstorecheckPostsIntegrity(Chandef results;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	child!0;
stop_process:
}
proctype sqlstorecheckSchemesIntegrity(Chandef results;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	child!0;
stop_process:
}
proctype sqlstorecheckSessionsIntegrity(Chandef results;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	child!0;
stop_process:
}
proctype sqlstorecheckTeamsIntegrity(Chandef results;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	child!0;
stop_process:
}
proctype sqlstorecheckUsersIntegrity(Chandef results;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
	child!0;
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

