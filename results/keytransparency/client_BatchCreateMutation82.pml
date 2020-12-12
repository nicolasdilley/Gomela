#define BatchCreateMutation_runtime_NumCPU11219  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example699315778/core/client/batch_client.go
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
	int runtime_NumCPU11219 = BatchCreateMutation_runtime_NumCPU11219;
	Chandef uChan;
	bool state = false;
	Chandef rChan;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(uChan);
	run sync_monitor(rChan);
	run Anonymous0(uChan,rChan);
	run Anonymous1(uChan,rChan);
	do
	:: rChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: rChan.async_rcv?0;
			:: rChan.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef uChan;Chandef rChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		
		if
		:: uChan.async_send!0;
		:: uChan.sync!0 -> 
			uChan.sending?0
		fi
	:: true -> 
		break
	od;
stop_process:	uChan.closing!true
}
proctype Anonymous1(Chandef uChan;Chandef rChan) {
	bool closed; 
	int i;
	bool state;
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. runtime_NumCPU11219-1) {
for30:		wg.Add!1;
		run Anonymous1(uChan,rChan)
	};
for30_exit:stop_process:	rChan.closing!true;
	wg.Wait?0
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

