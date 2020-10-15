#define Read_series  60
#define Read_samples  60
#define Read_deletes  60
#define Read_s_Intervals  60
#define lb_for914_4  -1
#define ub_for914_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example961834975/tsdb/wal.go
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
	Chandef donec;
	int deletes = Read_deletes;
	int series = Read_series;
	int i;
	Chandef datac;
	int samples = Read_samples;
	int s_Intervals = Read_s_Intervals;
	bool state = false;
	run sync_monitor(donec);
	
	if
	:: 100 > 0 -> 
		datac.size = 100;
		run emptyChan(datac)
	:: else -> 
		run sync_monitor(datac)
	fi;
	run Anonymous0(donec,datac);
	
	if
	:: lb_for914_4 != -1 && ub_for914_5 != -1 -> 
				for(i : lb_for914_4.. ub_for914_5) {
for20:			

			if
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: datac.async_send!0;
				:: datac.sync!0 -> 
					datac.sending?0
				fi;
								for(i : 1.. series) {
for21:
				}
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: datac.async_send!0;
				:: datac.sync!0 -> 
					datac.sending?0
				fi;
								for(i : 1.. samples) {
for22:
				}
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: datac.async_send!0;
				:: datac.sync!0 -> 
					datac.sending?0
				fi;
								for(i : 1.. deletes) {
for23:										for(i : 1.. s_Intervals) {
for24:
					}
				}
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			

			if
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: datac.async_send!0;
				:: datac.sync!0 -> 
					datac.sending?0
				fi;
								for(i : 1.. series) {
for21:
				}
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: datac.async_send!0;
				:: datac.sync!0 -> 
					datac.sending?0
				fi;
								for(i : 1.. samples) {
for22:
				}
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: datac.async_send!0;
				:: datac.sync!0 -> 
					datac.sending?0
				fi;
								for(i : 1.. deletes) {
for23:										for(i : 1.. s_Intervals) {
for24:
					}
				}
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	datac.closing!true;
	
	if
	:: donec.async_rcv?0;
	:: donec.sync?0;
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
stop_process:}

proctype Anonymous0(Chandef donec;Chandef datac) {
	bool closed; 
	int i;
	bool state;
	do
	:: datac.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: datac.async_rcv?0;
			:: datac.sync?0;
			fi
		fi
	od;
	donec.closing!true;
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

