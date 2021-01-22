
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example810706838/controller/client/v1/client.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	chan child_v1controllernewJobWatcher1 = [0] of {int};
	chan child_StreamJobEvents0 = [0] of {int};
	Chandef events;
	int num_msgs = 0;
	bool state = false;
	int i;
	run sync_monitor(events);
	run StreamJobEvents(events,child_StreamJobEvents0);
	child_StreamJobEvents0?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run v1controllernewJobWatcher(events,child_v1controllernewJobWatcher1);
	child_v1controllernewJobWatcher1?0;
	goto stop_process
stop_process:skip
}

proctype StreamJobEvents(Chandef output;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StreamEvents0 = [0] of {int};
	Chandef appEvents;
	run sync_monitor(appEvents);
	run go_convertEvents(appEvents);
	run StreamEvents(appEvents,child_StreamEvents0);
	child_StreamEvents0?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype go_convertEvents(Chandef appEvents) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		

		if
		:: appEvents.async_rcv?state,num_msgs;
		:: appEvents.sync?state,num_msgs;
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
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip
}
proctype StreamEvents(Chandef output;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype v1controllernewJobWatcher(Chandef events;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

