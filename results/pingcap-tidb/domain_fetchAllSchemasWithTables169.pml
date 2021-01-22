#define fetchAllSchemasWithTables_splittedSchemas  3
#define not_found_177  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example369350292/domain/domain.go
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
	Chandef doneCh;
	int num_msgs = 0;
	bool state = false;
	int i;
	int splittedSchemas = fetchAllSchemasWithTables_splittedSchemas;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: splittedSchemas > 0 -> 
		doneCh.size = splittedSchemas;
		run AsyncChan(doneCh)
	:: else -> 
		run sync_monitor(doneCh)
	fi;
		for(i : 0.. splittedSchemas-1) {
		for10: skip;
		run go_fetchSchemasWithTables(doneCh,not_found_177);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: splittedSchemas-1 != -3 -> 
				for(i : 0.. splittedSchemas-1) {
			for20: skip;
			

			if
			:: doneCh.async_rcv?state,num_msgs;
			:: doneCh.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20162: skip;
			

			if
			:: doneCh.async_rcv?state,num_msgs;
			:: doneCh.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end162: skip
		:: true -> 
			break
		od;
		for20_exit162: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_fetchSchemasWithTables(Chandef done;int schemas) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: schemas-1 != -3 -> 
				for(i : 0.. schemas-1) {
			for11: skip;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: done.async_send!0;
				:: done.sync!false,0 -> 
					done.sending?state
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
			for11161: skip;
			

			if
			:: true -> 
				goto for11_end161
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: done.async_send!0;
				:: done.sync!false,0 -> 
					done.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			for11_end161: skip
		:: true -> 
			break
		od;
		for11_exit161: skip
	fi;
	

	if
	:: done.async_send!0;
	:: done.sync!false,0 -> 
		done.sending?state
	fi;
	stop_process: skip
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

