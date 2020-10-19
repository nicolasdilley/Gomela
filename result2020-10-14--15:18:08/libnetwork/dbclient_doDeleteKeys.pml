#define doDeleteKeys_parallelWriters  60
#define doDeleteKeys_servicePort  60
#define lb_for179_2  -1
#define ub_for179_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example774418136/cmd/networkdb-test/dbclient/ndbClient.go
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
	chan child_dbclientwaitWriters0 = [0] of {int};
	int i;
	int parallelWriters = doDeleteKeys_parallelWriters;
	Chandef doneCh;
	chan child_dbclientwaitWriters1 = [0] of {int};
	int servicePort = doDeleteKeys_servicePort;
	bool state = false;
	
	if
	:: parallelWriters > 0 -> 
		doneCh.size = parallelWriters;
		run emptyChan(doneCh)
	:: else -> 
		run sync_monitor(doneCh)
	fi;
		for(i : 0.. parallelWriters-1) {
for10:		run go_dbclientclientWatchTable(doneCh)
	};
for10_exit:	run dbclientwaitWriters(doneCh,parallelWriters,child_dbclientwaitWriters0);
	child_dbclientwaitWriters0?0;
		for(i : 0.. parallelWriters-1) {
for30:		run go_dbclientdeleteKeysNumber(doneCh,servicePort)
	};
for30_exit:	run dbclientwaitWriters(doneCh,child_dbclientwaitWriters1);
	child_dbclientwaitWriters1?0;
	doneCh.closing!true
stop_process:}

proctype go_dbclientclientWatchTable(Chandef doneCh) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: doneCh.async_send!0;
		:: doneCh.sync!0 -> 
			doneCh.sending?0
		fi
	:: true;
	fi;
stop_process:
}
proctype dbclientwaitWriters(Chandef doneCh;int parallelWriters;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && parallelWriters-1 != -1 -> 
				for(i : 0.. parallelWriters-1) {
for20:			
			if
			:: doneCh.async_rcv?0;
			:: doneCh.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: doneCh.async_rcv?0;
			:: doneCh.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process;
	child!0;
stop_process:
}
proctype go_dbclientdeleteKeysNumber(Chandef doneCh;int number) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for179_2 != -1 && ub_for179_3 != -1 -> 
				for(i : lb_for179_2.. ub_for179_3) {
for31:
		}
	:: else -> 
		do
		:: true -> 
for31:
		:: true -> 
			break
		od
	fi;
for31_exit:	
	if
	:: doneCh.async_send!0;
	:: doneCh.sync!0 -> 
		doneCh.sending?0
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

