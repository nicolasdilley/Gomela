#define List_types_DefaultEventChanSize  0

// /tmp/clone-example746219978/src/storage/stream/event/list.go
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
	int types_DefaultEventChanSize = List_types_DefaultEventChanSize;
	Chandef eventChan;
	int i;
	
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
	:: types_DefaultEventChanSize > 0 -> 
		eventChan.size = types_DefaultEventChanSize;
		run AsyncChan(eventChan)
	:: else -> 
		run sync_monitor(eventChan)
	fi;
	run Anonymous0(eventChan);
	goto stop_process
stop_process:}

proctype elister(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int opts_Fields = -2;
	
	if
	:: lb_for62_1 != -2 && ub_for62_2 != -2 -> 
				for(i : lb_for62_1.. ub_for62_2) {
for10:			
			if
			:: true -> 
								for(i : 0.. opts_Fields-1) {
for11:
				}
			:: true;
			fi;
retry:			;
			
			if
			:: lb_for89_3 != -2 && ub_for89_4 != -2 -> 
								for(i : lb_for89_3.. ub_for89_4) {
for12:					do
					:: true -> 
						break
					od;
					
					if
					:: true -> 
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						goto retry
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for12:					do
					:: true -> 
						break
					od;
					
					if
					:: true -> 
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						goto retry
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for12_exit:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto retry
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
								for(i : 0.. opts_Fields-1) {
for11:
				}
			:: true;
			fi;
retry:			;
			
			if
			:: lb_for89_3 != -2 && ub_for89_4 != -2 -> 
								for(i : lb_for89_3.. ub_for89_4) {
for12:					do
					:: true -> 
						break
					od;
					
					if
					:: true -> 
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						goto retry
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for12:					do
					:: true -> 
						break
					od;
					
					if
					:: true -> 
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						goto retry
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for12_exit:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto retry
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:stop_process:	child!0
}
proctype Anonymous0(Chandef eventChan) {
	bool closed; 
	int i;
	bool state;
	chan child_elister0 = [0] of {int};
	run elister(eventChan,child_elister0);
	child_elister0?0;
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

