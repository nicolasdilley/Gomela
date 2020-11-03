#define manageConnections_srv_idleConnections 0
#define manageConnections_srv_connections 1
#define lb_for365_2  -1
#define ub_for365_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example731975002/graceful.go
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
	Chandef quitting;
	Chandef active;
	Chandef add;
	Chandef shutdown;
	int i;
	Chandef idle;
	Chandef remove;
	Chandef kill;
	chan child_srvshutdown0 = [0] of {int};
	bool state = false;
	run sync_monitor(add);
	run sync_monitor(idle);
	run sync_monitor(active);
	run sync_monitor(remove);
	run sync_monitor(shutdown);
	run sync_monitor(kill);
	run go_srvmanageConnections(add,idle,active,remove,shutdown,kill);
	run sync_monitor(quitting);
	run go_srvhandleInterrupt(quitting);
	
	if
	:: true -> 
		do
		:: quitting.async_rcv?0 -> 
			break
		:: quitting.sync?0 -> 
			break
		:: true -> 
			break
		od
	:: true;
	fi;
	run srvshutdown(shutdown,kill,child_srvshutdown0);
	child_srvshutdown0?0;
	goto stop_process
stop_process:}

proctype go_srvmanageConnections(Chandef add;Chandef idle;Chandef active;Chandef remove;Chandef shutdown;Chandef kill) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: add.async_rcv?0 -> 
			break
		:: add.sync?0 -> 
			break
		:: idle.async_rcv?0 -> 
			break
		:: idle.sync?0 -> 
			break
		:: active.async_rcv?0 -> 
			break
		:: active.sync?0 -> 
			break
		:: remove.async_rcv?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: remove.sync?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: shutdown.async_rcv?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
						for(i : 0.. srv_idleConnections-1) {
for11:
			};
			break
		:: shutdown.sync?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
						for(i : 0.. srv_idleConnections-1) {
for11:
			};
			break
		:: kill.async_rcv?0 -> 
						for(i : 0.. srv_connections-1) {
for12:
			};
			goto stop_process
		:: kill.sync?0 -> 
						for(i : 0.. srv_connections-1) {
for12:
			};
			goto stop_process
		od
	od;
for10_exit:stop_process:
}
proctype go_srvhandleInterrupt(Chandef quitting) {
	bool closed; 
	int i;
	bool state;
		for(i : 0.. interrupt-1) {
for20:		quitting.closing!true
	};
stop_process:
}
proctype srvshutdown(Chandef shutdown;Chandef kill;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef done;
	run sync_monitor(done);
	
	if
	:: shutdown.async_send!0;
	:: shutdown.sync!0 -> 
		shutdown.sending?0
	fi;
	
	if
	:: true -> 
		do
		:: done.async_rcv?0 -> 
			break
		:: done.sync?0 -> 
			break
		:: true -> 
			kill.closing!true
		od
	:: true -> 
		
		if
		:: done.async_rcv?0;
		:: done.sync?0;
		fi
	:: true -> 
		
		if
		:: done.async_rcv?0;
		:: done.sync?0;
		fi
	fi;
stop_process:	child!0
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


