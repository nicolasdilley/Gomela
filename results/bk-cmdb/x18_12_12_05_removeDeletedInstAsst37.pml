#define removeDeletedInstAsst_assts  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example672779410/src/scene_server/admin_server/upgrader/x18.12.12.05/remove_deleted_inst_asst.go
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
	Chandef errChan;
	Chandef instAsstQueue;
	int i;
	Chandef asstNameChan;
	int assts = removeDeletedInstAsst_assts;
	bool state = false;
	
	if
	:: 1000 > 0 -> 
		instAsstQueue.size = 1000;
		run AsyncChan(instAsstQueue)
	:: else -> 
		run sync_monitor(instAsstQueue)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: assts > 0 -> 
		asstNameChan.size = assts;
		run AsyncChan(asstNameChan)
	:: else -> 
		run sync_monitor(asstNameChan)
	fi;
		for(i : 0.. assts-1) {
for10:		
		if
		:: asstNameChan.async_send!0;
		:: asstNameChan.sync!0 -> 
			asstNameChan.sending?0
		fi
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1000 > 0 -> 
		errChan.size = 1000;
		run AsyncChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	run Anonymous0(instAsstQueue,asstNameChan,errChan);
	do
	:: errChan.async_rcv?0 -> 
		goto stop_process
	:: errChan.sync?0 -> 
		goto stop_process
	od;
	run Anonymous1(instAsstQueue,asstNameChan,errChan);
	do
	:: errChan.async_rcv?0 -> 
		goto stop_process
	:: errChan.sync?0 -> 
		goto stop_process
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef instAsstQueue;Chandef asstNameChan;Chandef errChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			asstNameChan.closing!true;
			break
		:: true;
		fi
	:: true -> 
		break
	od;
stop_process:
}
proctype Anonymous1(Chandef instAsstQueue;Chandef asstNameChan;Chandef errChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for30:		
		if
		:: true -> 
			instAsstQueue.closing!true;
			break
		:: true;
		fi
	:: true -> 
		break
	od;
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

