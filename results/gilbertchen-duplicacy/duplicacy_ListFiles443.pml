#define ub_for492_0  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example922597344/src/duplicacy_gcdstorage.go
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
	Chandef directoryChannel;
	Chandef errorChannel;
	int num_msgs = 0;
	bool state = false;
	int i;
	int entries=1;
	

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
					:: errorChannel.async_rcv?state,num_msgs -> 
						goto stop_process
					:: errorChannel.sync?state,num_msgs -> 
						goto stop_process
					:: directoryChannel.async_rcv?state,num_msgs -> 
						break
					:: directoryChannel.sync?state,num_msgs -> 
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
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: errorChannel.async_send!0;
		:: errorChannel.sync!false,0 -> 
			errorChannel.sending?state
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
				:: directoryChannel.sync!false,0 -> 
					directoryChannel.sending?state
				fi
			fi;
			for41_end: skip
		};
		for41_exit: skip
	:: else -> 
		do
		:: true -> 
			for411304: skip;
			

			if
			:: true -> 
				

				if
				:: directoryChannel.async_send!0;
				:: directoryChannel.sync!false,0 -> 
					directoryChannel.sending?state
				fi
			fi;
			for41_end1304: skip
		:: true -> 
			break
		od;
		for41_exit1304: skip
	fi;
	

	if
	:: directoryChannel.async_send!0;
	:: directoryChannel.sync!false,0 -> 
		directoryChannel.sending?state
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


