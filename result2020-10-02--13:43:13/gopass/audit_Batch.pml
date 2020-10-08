
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example040444667/internal/audit/audit.go
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
	Chandef checked;
	int i;
	int maxJobs = 5;
	Chandef pending;
	Chandef done;
	int secret_messages = 5;
	bool state = false;
	
	if
	:: 100 > 0 -> 
		pending.size = 100;
		run emptyChan(pending)
	:: else -> 
		run sync_monitor(pending)
	fi;
	
	if
	:: 100 > 0 -> 
		checked.size = 100;
		run emptyChan(checked)
	:: else -> 
		run sync_monitor(checked)
	fi;
	
	if
	:: maxJobs > 0 -> 
		done.size = maxJobs;
		run emptyChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
		for(i : 0.. maxJobs-1) {
for10:		run go_auditaudit(pending,checked,done)
	};
for10_exit:	run Anonymous1(pending,checked,done);
	run Anonymous2(pending,checked,done);
	do
	:: checked.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: checked.async_rcv?0;
			:: checked.sync?0;
			fi;
						for(i : 1.. secret_messages) {
for41:
			};
			
			if
			:: true -> 
				break
			:: true;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype go_auditaudit(Chandef secrets;Chandef checked;Chandef done) {
	bool closed; 
	int i;
	do
	:: secrets.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: secrets.async_rcv?0;
			:: secrets.sync?0;
			fi;
			do
			:: true -> 
				
				if
				:: checked.async_send!0;
				:: checked.sync!0 -> 
					checked.sending?0
				fi
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				
				if
				:: checked.async_send!0;
				:: checked.sync!0 -> 
					checked.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: checked.async_send!0;
				:: checked.sync!0 -> 
					checked.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
								for(i : 1.. errs) {
for12:
				};
				
				if
				:: checked.async_send!0;
				:: checked.sync!0 -> 
					checked.sending?0
				fi
			:: true;
			fi;
			
			if
			:: checked.async_send!0;
			:: checked.sync!0 -> 
				checked.sending?0
			fi
		fi
	od;
	
	if
	:: done.async_send!0;
	:: done.sync!0 -> 
		done.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef pending;Chandef checked;Chandef done) {
	bool closed; 
	int i;
		for(i : 1.. secrets) {
for20:		
		if
		:: pending.async_send!0;
		:: pending.sync!0 -> 
			pending.sending?0
		fi
	};
	pending.closing!true;
stop_process:
}
proctype Anonymous2(Chandef pending;Chandef checked;Chandef done) {
	bool closed; 
	int i;
	
	if
	:: 0 != -1 && maxJobs-1 != -1 -> 
				for(i : 0.. maxJobs-1) {
for30:			
			if
			:: done.async_rcv?0;
			:: done.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: done.async_rcv?0;
			:: done.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	checked.closing!true;
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

