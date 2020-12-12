
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example779298573/core/chaincode/shim/chaincode.go
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
	Chandef rows;
	bool state = false;
	int i;
	
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
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		Chandef rows;
		run sync_monitor(rows);
		run Anonymous0(rows,rows);
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(rows);
	run Anonymous1(rows,rows);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef rows;Chandef rows) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: rows.async_send!0;
	:: rows.sync!0 -> 
		rows.sending?0
	fi;
	rows.closing!true;
stop_process:
}
proctype Anonymous1(Chandef rows;Chandef rows) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for580_0 != -2 && ub_for580_1 != -2 -> 
				for(i : lb_for580_0.. ub_for580_1) {
for10:			
			if
			:: true -> 
				rows.closing!true
			:: true;
			fi;
			
			if
			:: true -> 
				rows.closing!true
			:: true;
			fi;
			
			if
			:: rows.async_send!0;
			:: rows.sync!0 -> 
				rows.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				rows.closing!true
			:: true;
			fi;
			
			if
			:: true -> 
				rows.closing!true
			:: true;
			fi;
			
			if
			:: rows.async_send!0;
			:: rows.sync!0 -> 
				rows.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	rows.closing!true;
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

