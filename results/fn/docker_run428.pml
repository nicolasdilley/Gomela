
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example712284945/api/agent/drivers/docker/docker.go
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
	Chandef successChan;
	int i;
	Chandef stopSignal;
	bool state = false;
	run sync_monitor(successChan);
	
	if
	:: true -> 
		Chandef mon;
		run sync_monitor(mon);
		run Anonymous0(successChan,mon,stopSignal);
		do
		:: mon.async_rcv?0 -> 
			break
		:: mon.sync?0 -> 
			break
		od
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(stopSignal);
	run go_collectStats(stopSignal);
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef successChan;Chandef mon;Chandef stopSignal) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: successChan.async_rcv?0;
	:: successChan.sync?0;
	fi;
	
	if
	:: successChan.async_send!0;
	:: successChan.sync!0 -> 
		successChan.sending?0
	fi;
	mon.closing!true;
stop_process:
}
proctype go_collectStats(Chandef stopSignal) {
	bool closed; 
	int i;
	bool state;
	Chandef dockerCallDone;
	Chandef dstats;
	run sync_monitor(dockerCallDone);
	
	if
	:: 1 > 0 -> 
		dstats.size = 1;
		run AsyncChan(dstats)
	:: else -> 
		run sync_monitor(dstats)
	fi;
	run Anonymous2(dockerCallDone,dstats,stopSignal);
	do
	:: true -> 
for10:		do
		:: stopSignal.async_rcv?0 -> 
			goto stop_process
		:: stopSignal.sync?0 -> 
			goto stop_process
		:: dstats.async_rcv?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: dstats.sync?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		od
	od;
for10_exit:stop_process:	dockerCallDone.closing!true
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

