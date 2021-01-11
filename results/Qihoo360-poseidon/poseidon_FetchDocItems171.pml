#define FetchDocItems_docItems  1
#define not_found_216  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example104432452/service/searcher/poseidon/doc_gz_client.go
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
	int docItems = FetchDocItems_docItems;
	run sync_monitor(ch);
		for(i : 0.. docItems-1) {
		for20: skip;
		

		if
		:: true -> 
			run go_Anonymous0(ch,not_found_216)
		:: true;
		fi;
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: 0 != -2 && docItems-1 != -3 -> 
				for(i : 0.. docItems-1) {
			for302079: skip;
			do
			:: ch.async_rcv?0 -> 
				break
			:: ch.sync?0 -> 
				break
			od;
			for30_end2079: skip
		};
		for30_exit2079: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			do
			:: ch.async_rcv?0 -> 
				break
			:: ch.sync?0 -> 
				break
			od;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef ch;int rowIndexList) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: rowIndexList-1 != -3 -> 
				for(i : 0.. rowIndexList-1) {
			for21: skip;
			

			if
			:: true -> 
				

				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi
			:: true -> 
				

				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi
			:: true -> 
				

				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for212077: skip;
			

			if
			:: true -> 
				

				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi
			:: true -> 
				

				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi
			:: true -> 
				

				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi
			fi;
			for21_end2077: skip
		:: true -> 
			break
		od;
		for21_exit2077: skip
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

