#define SuggestPrice_gpo_checkBlocks  1
#define ub_for106_1  1
#define ub_for113_2  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example434979571/eth/gasprice/gasprice.go
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
	Chandef ch;
	bool state = false;
	int i;
	int gpo_checkBlocks = SuggestPrice_gpo_checkBlocks;
	

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
	:: gpo_checkBlocks > 0 -> 
		ch.size = gpo_checkBlocks;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
		for(i : 0.. ub_for106_1) {
		for10: skip;
		run go_getBlockPrices(ch);
		for10_end: skip
	};
	for10_exit: skip;
		for(i : 0.. ub_for113_2) {
		for20: skip;
		

		if
		:: ch.async_rcv?0;
		:: ch.sync?0;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto for20_end
		:: true;
		fi;
		

		if
		:: true -> 
			goto for20_end
		:: true;
		fi;
		

		if
		:: true -> 
			run go_getBlockPrices(ch)
		:: true;
		fi;
		for20_end: skip
	};
	for20_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_getBlockPrices(Chandef ch) {
	bool closed; 
	int i;
	bool state;
	int txs=3;
	

	if
	:: true -> 
		

		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: txs-1 != -3 -> 
				for(i : 0.. txs-1) {
			for11: skip;
			

			if
			:: true -> 
				

				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for111096: skip;
			

			if
			:: true -> 
				

				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			for11_end1096: skip
		:: true -> 
			break
		od;
		for11_exit1096: skip
	fi;
	

	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	stop_process: skip
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


