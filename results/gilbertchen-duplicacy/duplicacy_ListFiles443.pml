#define ub_for492_0  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example788564112/src/duplicacy_gcdstorage.go
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
	Chandef directoryChannel;
	Chandef errorChannel;
	bool state = false;
	int i;
	int entries = -2;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			

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
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: true -> 
			run sync_monitor(errorChannel);
			run sync_monitor(directoryChannel);
						for(i : 0.. ub_for492_0) {
				for40: skip;
				

				if
				:: true -> 
					run go_Anonymous0(errorChannel,directoryChannel,entries)
				:: true;
				fi;
				

				if
				:: true -> 
					do
					:: errorChannel.async_rcv?0 -> 
						goto stop_process
					:: errorChannel.sync?0 -> 
						goto stop_process
					:: directoryChannel.async_rcv?0 -> 
						break
					:: directoryChannel.sync?0 -> 
						break
					od
				:: true;
				fi;
				for40_end: skip
			};
			for40_exit: skip;
			goto stop_process
		:: true -> 
			run sync_monitor(errorChannel);
			run sync_monitor(directoryChannel);
						for(i : 0.. ub_for492_0) {
				for40: skip;
				

				if
				:: true -> 
					run go_Anonymous0(errorChannel,directoryChannel,entries)
				:: true;
				fi;
				

				if
				:: true -> 
					do
					:: errorChannel.async_rcv?0 -> 
						goto stop_process
					:: errorChannel.sync?0 -> 
						goto stop_process
					:: directoryChannel.async_rcv?0 -> 
						break
					:: directoryChannel.sync?0 -> 
						break
					od
				:: true;
				fi;
				for40_end: skip
			};
			for40_exit: skip;
			goto stop_process
		fi
	fi
stop_process:skip
}

proctype go_Anonymous0(Chandef errorChannel;Chandef directoryChannel;int entries) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: errorChannel.async_send!0;
		:: errorChannel.sync!0 -> 
			errorChannel.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: entries-1 != -3 -> 
				for(i : 0.. entries-1) {
			for41: skip;
			

			if
			:: true -> 
				

				if
				:: directoryChannel.async_send!0;
				:: directoryChannel.sync!0 -> 
					directoryChannel.sending?0
				fi
			:: true -> 
				

				if
				:: directoryChannel.async_send!0;
				:: directoryChannel.sync!0 -> 
					directoryChannel.sending?0
				fi
			fi;
			for41_end: skip
		};
		for41_exit: skip
	:: else -> 
		do
		:: true -> 
			for411278: skip;
			

			if
			:: true -> 
				

				if
				:: directoryChannel.async_send!0;
				:: directoryChannel.sync!0 -> 
					directoryChannel.sending?0
				fi
			:: true -> 
				

				if
				:: directoryChannel.async_send!0;
				:: directoryChannel.sync!0 -> 
					directoryChannel.sending?0
				fi
			fi;
			for41_end1278: skip
		:: true -> 
			break
		od;
		for41_exit1278: skip
	fi;
	

	if
	:: directoryChannel.async_send!0;
	:: directoryChannel.sync!0 -> 
		directoryChannel.sending?0
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

