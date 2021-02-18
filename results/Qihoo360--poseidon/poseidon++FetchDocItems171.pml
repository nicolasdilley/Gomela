#define FetchDocItems_docItems  3
#define not_found_216  -2

// https://github.com/Qihoo360/poseidon/blob/9be3a58756c2c604573075b6e7531f13f5ba7c1c/service/searcher/poseidon/doc_gz_client.go#L171
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
	Chandef ch;
	int num_msgs = 0;
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
			for30545: skip;
			do
			:: ch.async_rcv?state,num_msgs -> 
				break
			:: ch.sync?state,num_msgs -> 
				break
			od;
			for30_end545: skip
		};
		for30_exit545: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			do
			:: ch.async_rcv?state,num_msgs -> 
				break
			:: ch.sync?state,num_msgs -> 
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
	int num_msgs;
	

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
				:: ch.sync!false,0 -> 
					ch.sending?state
				fi
			:: true -> 
				

				if
				:: ch.async_send!0;
				:: ch.sync!false,0 -> 
					ch.sending?state
				fi
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for21543: skip;
			

			if
			:: true -> 
				

				if
				:: ch.async_send!0;
				:: ch.sync!false,0 -> 
					ch.sending?state
				fi
			:: true -> 
				

				if
				:: ch.async_send!0;
				:: ch.sync!false,0 -> 
					ch.sending?state
				fi
			fi;
			for21_end543: skip
		:: true -> 
			break
		od;
		for21_exit543: skip
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

