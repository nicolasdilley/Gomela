#define lb_for444_0  -1
#define ub_for444_1  -1
#define lb_for492_2  -1
#define ub_for492_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example261579306/src/duplicacy_gcdstorage.go
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
	int entries = -2;
	int files = -2;
	int i;
for10_exit:	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. files-1) {
for20:
		};
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
						for(i : 0.. entries-1) {
for30:
			};
			goto stop_process
		:: true -> 
			Chandef errorChannel;
			run sync_monitor(errorChannel);
			Chandef directoryChannel;
			run sync_monitor(directoryChannel);
						for(i : lb_for492_2.. ub_for492_3) {
for40:				
				if
				:: true -> 
					run Anonymous0(errorChannel,directoryChannel)
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
				fi
			};
for40_exit:			goto stop_process
		:: true -> 
			Chandef errorChannel;
			run sync_monitor(errorChannel);
			Chandef directoryChannel;
			run sync_monitor(directoryChannel);
						for(i : lb_for492_2.. ub_for492_3) {
for40:				
				if
				:: true -> 
					run Anonymous0(errorChannel,directoryChannel)
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
				fi
			};
for40_exit:			goto stop_process
		fi
	fi
stop_process:}

proctype Anonymous0(Chandef errorChannel;Chandef directoryChannel) {
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
	do
	:: true -> 
for41:		
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
		fi
	:: true -> 
		break
	od;
	
	if
	:: directoryChannel.async_send!0;
	:: directoryChannel.sync!0 -> 
		directoryChannel.sending?0
	fi;
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

