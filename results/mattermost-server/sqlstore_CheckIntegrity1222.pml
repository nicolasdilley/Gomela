
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example135141040/store/sqlstore/store.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
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
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
		  :: ch.sending!false;  // sending channel is open
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

