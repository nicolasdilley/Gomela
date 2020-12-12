
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example739541781/pkg/cri/server/service.go
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
	bool state = false;
	Chandef streamServerErrCh;
	Chandef cniNetConfMonitorErrCh;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		cniNetConfMonitorErrCh.size = 1;
		run AsyncChan(cniNetConfMonitorErrCh)
	:: else -> 
		run sync_monitor(cniNetConfMonitorErrCh)
	fi;
	run Anonymous0(cniNetConfMonitorErrCh,streamServerErrCh);
	run sync_monitor(streamServerErrCh);
	run Anonymous1(cniNetConfMonitorErrCh,streamServerErrCh);
	do
	:: streamServerErrCh.async_rcv?0 -> 
		break
	:: streamServerErrCh.sync?0 -> 
		break
	:: cniNetConfMonitorErrCh.async_rcv?0 -> 
		break
	:: cniNetConfMonitorErrCh.sync?0 -> 
		break
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: streamServerErrCh.async_rcv?0 -> 
		break
	:: streamServerErrCh.sync?0 -> 
		break
	:: true -> 
		break
	od;
	
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
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef cniNetConfMonitorErrCh;Chandef streamServerErrCh) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: cniNetConfMonitorErrCh.async_send!0;
	:: cniNetConfMonitorErrCh.sync!0 -> 
		cniNetConfMonitorErrCh.sending?0
	fi;
stop_process:	cniNetConfMonitorErrCh.closing!true
}
proctype Anonymous1(Chandef cniNetConfMonitorErrCh;Chandef streamServerErrCh) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: streamServerErrCh.async_send!0;
		:: streamServerErrCh.sync!0 -> 
			streamServerErrCh.sending?0
		fi
	:: true;
	fi;
stop_process:	streamServerErrCh.closing!true
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

