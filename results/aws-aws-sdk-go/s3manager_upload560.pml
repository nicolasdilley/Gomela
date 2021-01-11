#define upload_u_cfg_Concurrency  3
#define ub_for584_2  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example378112969/service/s3/s3manager/upload.go
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
	int u_cfg_Concurrency = upload_u_cfg_Concurrency;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: u_cfg_Concurrency > 0 -> 
		ch.size = u_cfg_Concurrency;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
		for(i : 0.. u_cfg_Concurrency-1) {
		for10: skip;
		run go_readChunk(ch);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	

	if
	:: 0 != -2 && ub_for584_2 != -2 -> 
				for(i : 0.. ub_for584_2) {
			for20719: skip;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			

			if
			:: ch.async_send!0;
			:: ch.sync!0 -> 
				ch.sending?0
			fi;
			for20_end719: skip
		};
		for20_exit719: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			

			if
			:: ch.async_send!0;
			:: ch.sync!0 -> 
				ch.sending?0
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	ch.closing!true;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_readChunk(Chandef ch) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for11: skip;
		

		if
		:: ch.async_rcv?0;
		:: ch.sync?0;
		fi;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		for11_end: skip
	od;
	for11_exit: skip;
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

