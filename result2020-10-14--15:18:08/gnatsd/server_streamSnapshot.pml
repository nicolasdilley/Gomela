#define lb_for1402_0  -1
#define ub_for1402_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example507681897/server/jetstream_api.go
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
	Chandef acks;
	Chandef inch;
	int i;
	chan child_acc_slRegisterNotification5 = [0] of {int};
	chan child_acc_slClearNotification8 = [0] of {int};
	bool state = false;
	
	if
	:: 1 > 0 -> 
		inch.size = 1;
		run emptyChan(inch)
	:: else -> 
		run sync_monitor(inch)
	fi;
	run acc_slRegisterNotification(inch,child_acc_slRegisterNotification0);
	child_acc_slRegisterNotification5?0;
	
	if
	:: inch.async_rcv?0;
	:: inch.sync?0;
	fi;
	
	if
	:: true -> 
		do
		:: inch.async_rcv?0 -> 
			break
		:: inch.sync?0 -> 
			break
		:: true;
		od
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		acks.size = 1;
		run emptyChan(acks)
	:: else -> 
		run sync_monitor(acks)
	fi;
	
	if
	:: acks.async_send!0;
	:: acks.sync!0 -> 
		acks.sending?0
	fi;
	
	if
	:: lb_for1402_0 != -1 && ub_for1402_1 != -1 -> 
				for(i : lb_for1402_0.. ub_for1402_1) {
for30:			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				do
				:: acks.async_rcv?0 -> 
					break
				:: acks.sync?0 -> 
					break
				:: inch.async_rcv?0 -> 
					goto done;
					break
				:: inch.sync?0 -> 
					goto done;
					break
				:: true;
				od
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				do
				:: acks.async_rcv?0 -> 
					break
				:: acks.sync?0 -> 
					break
				:: inch.async_rcv?0 -> 
					goto done;
					break
				:: inch.sync?0 -> 
					goto done;
					break
				:: true;
				od
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:done:	;
	run acc_slClearNotification(inch,child_acc_slClearNotification6);
	child_acc_slClearNotification8?0
stop_process:}

proctype acc_slRegisterNotification(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
		chan child_saddRemoveNotify1 = [0] of {int};
		run saddRemoveNotify(notify,child_saddRemoveNotify0);
		child_saddRemoveNotify1?0
	:: true -> 
		chan child_saddInsertNotify3 = [0] of {int};
		run saddInsertNotify(notify,child_saddInsertNotify2);
		child_saddInsertNotify3?0
	:: true -> 
		chan child_saddInsertNotify3 = [0] of {int};
		run saddInsertNotify(notify,child_saddInsertNotify2);
		child_saddInsertNotify3?0
	fi;
	
	if
	:: true -> 
		chan child_serversendNotification4 = [0] of {int};
		run serversendNotification(notify,child_serversendNotification4);
		child_serversendNotification4?0
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype saddRemoveNotify(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_saddNotify0 = [0] of {int};
	run saddNotify(notify,child_saddNotify0);
	child_saddNotify0?0;
	goto stop_process;
	child!0;
stop_process:
}
proctype saddNotify(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype saddInsertNotify(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_saddNotify2 = [0] of {int};
	run saddNotify(notify,child_saddNotify2);
	child_saddNotify2?0;
	goto stop_process;
	child!0;
stop_process:
}
proctype serversendNotification(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: ch.async_send!0 -> 
		break
	:: ch.sync!0 -> 
		ch.sending?0;
		break
	:: true -> 
		break
	od;
	child!0;
stop_process:
}
proctype acc_slClearNotification(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_serverchkAndRemove7 = [0] of {int};
	chan child_serverchkAndRemove6 = [0] of {int};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run serverchkAndRemove(notify,child_serverchkAndRemove6);
	child_serverchkAndRemove6?0;
	run serverchkAndRemove(notify,child_serverchkAndRemove7);
	child_serverchkAndRemove7?0;
	goto stop_process;
	child!0;
stop_process:
}
proctype serverchkAndRemove(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		break
	od;
	goto stop_process;
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

