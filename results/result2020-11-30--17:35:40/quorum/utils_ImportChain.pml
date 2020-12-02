#define lb_for131_0  -1
#define ub_for131_1  -1
#define lb_for137_2  -1
#define ub_for137_3  -1

// /tmp/clone-example903492413/cmd/utils/cmd.go
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
	Chandef interrupt;
	int i;
	Chandef stop;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		interrupt.size = 1;
		run AsyncChan(interrupt)
	:: else -> 
		run sync_monitor(interrupt)
	fi;
	run sync_monitor(stop);
	do
	:: interrupt!0 -> 
		break
	:: true -> 
		break
	od;
	run Anonymous0(interrupt,stop);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: lb_for131_0 != -2 && ub_for131_1 != -2 -> 
				for(i : lb_for131_0.. ub_for131_1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: lb_for137_2 != -2 && ub_for137_3 != -2 -> 
								for(i : lb_for137_2.. ub_for137_3) {
for11:					
					if
					:: true -> 
						break
					:: true -> 
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					fi
				}
			:: else -> 
				do
				:: true -> 
for11:					
					if
					:: true -> 
						break
					:: true -> 
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					fi
				:: true -> 
					break
				od
			fi;
for11_exit:			
			if
			:: true -> 
				break
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
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: lb_for137_2 != -2 && ub_for137_3 != -2 -> 
								for(i : lb_for137_2.. ub_for137_3) {
for11:					
					if
					:: true -> 
						break
					:: true -> 
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					fi
				}
			:: else -> 
				do
				:: true -> 
for11:					
					if
					:: true -> 
						break
					:: true -> 
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					fi
				:: true -> 
					break
				od
			fi;
for11_exit:			
			if
			:: true -> 
				break
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
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process;
	interrupt.closing!true
stop_process:}

proctype Anonymous0(Chandef interrupt;Chandef stop) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: interrupt.async_rcv?0;
	:: interrupt.sync?0;
	fi;
	stop.closing!true;
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

