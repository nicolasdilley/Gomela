#define loadEntities_existing  3
#define loadEntities_consts_ExpirationRestoreWorkerCount  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example661773598/vault/identity_store_util.go
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
	Chandef result;
	Chandef errs;
	Chandef quit;
	Chandef broker;
	int num_msgs = 0;
	bool state = false;
	int i;
	int consts_ExpirationRestoreWorkerCount = loadEntities_consts_ExpirationRestoreWorkerCount;
	int existing = loadEntities_existing;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(broker);
	run sync_monitor(quit);
	

	if
	:: existing > 0 -> 
		errs.size = existing;
		run AsyncChan(errs)
	:: else -> 
		run sync_monitor(errs)
	fi;
	

	if
	:: existing > 0 -> 
		result.size = existing;
		run AsyncChan(result)
	:: else -> 
		run sync_monitor(result)
	fi;
	for10_exit: skip;
	

	if
	:: 0 != -2 && existing-1 != -3 -> 
				for(i : 0.. existing-1) {
			for20130: skip;
			do
			:: errs.async_rcv?state,num_msgs -> 
				quit.closing!true;
				goto stop_process
			:: errs.sync?state,num_msgs -> 
				quit.closing!true;
				goto stop_process
			:: result.async_rcv?state,num_msgs -> 
				

				if
				:: true -> 
					goto for20_end130
				:: true;
				fi;
				break
			:: result.sync?state,num_msgs -> 
				

				if
				:: true -> 
					goto for20_end130
				:: true;
				fi;
				break
			od;
			for20_end130: skip
		};
		for20_exit130: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			do
			:: errs.async_rcv?state,num_msgs -> 
				quit.closing!true;
				goto stop_process
			:: errs.sync?state,num_msgs -> 
				quit.closing!true;
				goto stop_process
			:: result.async_rcv?state,num_msgs -> 
				

				if
				:: true -> 
					goto for20_end
				:: true;
				fi;
				break
			:: result.sync?state,num_msgs -> 
				

				if
				:: true -> 
					goto for20_end
				:: true;
				fi;
				break
			od;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	goto stop_process
stop_process:skip
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

