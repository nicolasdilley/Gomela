#define multiSort_sortVals  60
#define multiSort_r_reply_UidMatrix  60
#define multiSort_ul_Uids  60
#define multiSort_ts_Order  60
#define multiSort_dest_Uids  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example897304492/worker/sort.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	bool state = false;
	int ul_Uids = multiSort_ul_Uids;
	int sortVals = multiSort_sortVals;
	int dest_Uids = multiSort_dest_Uids;
	Chandef och;
	int r_reply_UidMatrix = multiSort_r_reply_UidMatrix;
	int ts_Order = multiSort_ts_Order;
	int i;
		for(i : 1.. sortVals) {
for10:
	};
		for(i : 1.. r_reply_UidMatrix) {
for20:				for(i : 1.. ul_Uids) {
for21:
		}
	};
	
	if
	:: ts_Order - 1 > 0 -> 
		och.size = ts_Order - 1;
		run emptyChan(och)
	:: else -> 
		run sync_monitor(och)
	fi;
		for(i : 1.. ts_Order-1) {
for30:		run go_workerfetchValues(och)
	};
for30_exit:	
	if
	:: 1 != -1 && ts_Order-1 != -1 -> 
				for(i : 1.. ts_Order-1) {
for40:			
			if
			:: och.async_rcv?0;
			:: och.sync?0;
			fi;
						for(i : 1.. dest_Uids) {
for41:				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				fi
			}
		}
	:: else -> 
		do
		:: true -> 
for40:			
			if
			:: och.async_rcv?0;
			:: och.sync?0;
			fi;
						for(i : 1.. dest_Uids) {
for41:				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				fi
			}
		:: true -> 
			break
		od
	fi;
for40_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. ts_Order) {
for50:
	};
		for(i : 1.. r_reply_UidMatrix) {
for60:				for(i : 1.. ul_Uids) {
for61:
		};
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	goto stop_process
stop_process:}

proctype go_workerfetchValues(Chandef or) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: or.async_send!0;
	:: or.sync!0 -> 
		or.sending?0
	fi;
stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

