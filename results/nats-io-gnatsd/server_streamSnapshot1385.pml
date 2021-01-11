#define ub_for1432_0  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example111195339/server/jetstream_api.go
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
	chan child_ClearNotification1 = [0] of {int};
	Chandef acks;
	chan child_RegisterNotification0 = [0] of {int};
	Chandef inch;
	bool state = false;
	int i;
	

	if
	:: 1 > 0 -> 
		inch.size = 1;
		run AsyncChan(inch)
	:: else -> 
		run sync_monitor(inch)
	fi;
	run RegisterNotification(inch,child_RegisterNotification0);
	child_RegisterNotification0?0;
	

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
		:: true -> 
			break
		od
	:: true;
	fi;
	

	if
	:: 1 > 0 -> 
		acks.size = 1;
		run AsyncChan(acks)
	:: else -> 
		run sync_monitor(acks)
	fi;
	

	if
	:: acks.async_send!0;
	:: acks.sync!0 -> 
		acks.sending?0
	fi;
	

	if
	:: 0 != -2 && ub_for1432_0 != -2 -> 
				for(i : 0.. ub_for1432_0) {
			for50704: skip;
			

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
					goto done704;
					break
				:: inch.sync?0 -> 
					goto done704;
					break
				:: true -> 
					break
				od
			:: true;
			fi;
			for50_end704: skip
		};
		for50_exit704: skip
	:: else -> 
		do
		:: true -> 
			for50: skip;
			

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
				:: true -> 
					break
				od
			:: true;
			fi;
			for50_end: skip
		:: true -> 
			break
		od;
		for50_exit: skip
	fi;
	done: skip;
	;
	child_ClearNotification1?0;
	run ClearNotification(inch,child_ClearNotification1)
stop_process:skip
}

proctype RegisterNotification(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_serversendNotification2 = [0] of {int};
	chan child_addRemoveNotify0 = [0] of {int};
	chan child_addInsertNotify1 = [0] of {int};
	

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
		run addRemoveNotify(notify,child_addRemoveNotify0);
		child_addRemoveNotify0?0
	:: true -> 
		run addInsertNotify(notify,child_addInsertNotify1);
		child_addInsertNotify1?0
	:: true -> 
		run addInsertNotify(notify,child_addInsertNotify1);
		child_addInsertNotify1?0
	fi;
	

	if
	:: true -> 
		run serversendNotification(notify,child_serversendNotification2);
		child_serversendNotification2?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype addRemoveNotify(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_addNotify0 = [0] of {int};
	run addNotify(notify,child_addNotify0);
	child_addNotify0?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype addNotify(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype addInsertNotify(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_addNotify1 = [0] of {int};
	run addNotify(notify,child_addNotify1);
	child_addNotify1?0;
	goto stop_process;
	stop_process: skip;
	child!0
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
	:: true;
	od;
	stop_process: skip;
	child!0
}
proctype ClearNotification(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_serverchkAndRemove2 = [0] of {int};
	chan child_serverchkAndRemove1 = [0] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run serverchkAndRemove(notify,child_serverchkAndRemove1);
	child_serverchkAndRemove1?0;
	run serverchkAndRemove(notify,child_serverchkAndRemove2);
	child_serverchkAndRemove2?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype serverchkAndRemove(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
	stop_process: skip;
	child!0
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

