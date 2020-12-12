#define VerifyHeaders_headers  ??
#define VerifyHeaders_workers  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example440247525/consensus/ethash/consensus.go
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
	Chandef errorsOut;
	Chandef done;
	int workers = VerifyHeaders_workers;
	Chandef inputs;
	Chandef abort;
	int headers = VerifyHeaders_headers;
	int i;
	
	if
	:: true -> 
		Chandef results;
		
		if
		:: headers > 0 -> 
			results.size = headers;
			run AsyncChan(results)
		:: else -> 
			run sync_monitor(results)
		fi;
		Chandef abort;
		run sync_monitor(abort);
		
		if
		:: 0 != -2 && headers-1 != -3 -> 
						for(i : 0.. headers-1) {
for10:				
				if
				:: results.async_send!0;
				:: results.sync!0 -> 
					results.sending?0
				fi
			}
		:: else -> 
			do
			:: true -> 
for10:				
				if
				:: results.async_send!0;
				:: results.sync!0 -> 
					results.sending?0
				fi
			:: true -> 
				break
			od
		fi;
for10_exit:		goto stop_process
	:: true;
	fi;
	run sync_monitor(inputs);
	
	if
	:: workers > 0 -> 
		done.size = workers;
		run AsyncChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	run sync_monitor(abort);
for20_exit:	
	if
	:: headers > 0 -> 
		errorsOut.size = headers;
		run AsyncChan(errorsOut)
	:: else -> 
		run sync_monitor(errorsOut)
	fi;
	run Anonymous1(abort,results,inputs,done,abort,errorsOut);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef abort;Chandef results;Chandef inputs;Chandef done;Chandef abort;Chandef errorsOut) {
	bool closed; 
	int i;
	bool state;
	do
	:: inputs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: inputs.async_rcv?0;
			:: inputs.sync?0;
			fi;
			
			if
			:: done.async_send!0;
			:: done.sync!0 -> 
				done.sending?0
			fi
		fi
	od;
stop_process:
}
proctype Anonymous1(Chandef abort;Chandef results;Chandef inputs;Chandef done;Chandef abort;Chandef errorsOut) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for30:		do
		:: inputs.async_send!0 -> 
			break
		:: inputs.sync!0 -> 
			inputs.sending?0;
			break
		:: done.async_rcv?0 -> 
			
			if
			:: lb_for153_4 != -2 && ub_for153_5 != -2 -> 
								for(i : lb_for153_4.. ub_for153_5) {
for31:					
					if
					:: errorsOut.async_send!0;
					:: errorsOut.sync!0 -> 
						errorsOut.sending?0
					fi;
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for31:					
					if
					:: errorsOut.async_send!0;
					:: errorsOut.sync!0 -> 
						errorsOut.sending?0
					fi;
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for31_exit:			break
		:: done.sync?0 -> 
			
			if
			:: lb_for153_4 != -2 && ub_for153_5 != -2 -> 
								for(i : lb_for153_4.. ub_for153_5) {
for31:					
					if
					:: errorsOut.async_send!0;
					:: errorsOut.sync!0 -> 
						errorsOut.sending?0
					fi;
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for31:					
					if
					:: errorsOut.async_send!0;
					:: errorsOut.sync!0 -> 
						errorsOut.sending?0
					fi;
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for31_exit:			break
		:: abort.async_rcv?0 -> 
			goto stop_process
		:: abort.sync?0 -> 
			goto stop_process
		od
	od;
for30_exit:stop_process:	inputs.closing!true
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

