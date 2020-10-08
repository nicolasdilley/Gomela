#define lb_for167_0  -1
#define ub_for167_1  -1
#define lb_for198_2  -1
#define ub_for198_3  -1
#define lb_for244_4  -1
#define ub_for244_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example933794056/ethstats/ethstats.go
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
	Chandef chainHeadCh;
	Chandef txCh;
	Chandef quitCh;
	int i;
	Chandef txEventCh;
	Chandef headCh;
	int urls = 5;
	bool state = false;
	
	if
	:: 10 > 0 -> 
		chainHeadCh.size = 10;
		run emptyChan(chainHeadCh)
	:: else -> 
		run sync_monitor(chainHeadCh)
	fi;
	
	if
	:: 4096 > 0 -> 
		txEventCh.size = 4096;
		run emptyChan(txEventCh)
	:: else -> 
		run sync_monitor(txEventCh)
	fi;
	run sync_monitor(quitCh);
	
	if
	:: 1 > 0 -> 
		headCh.size = 1;
		run emptyChan(headCh)
	:: else -> 
		run sync_monitor(headCh)
	fi;
	
	if
	:: 1 > 0 -> 
		txCh.size = 1;
		run emptyChan(txCh)
	:: else -> 
		run sync_monitor(txCh)
	fi;
	run Anonymous0(chainHeadCh,txEventCh,quitCh,headCh,txCh);
		for(i : lb_for198_2.. ub_for198_3) {
for20:				for(i : 1.. urls) {
for21:			
			if
			:: true -> 
				break
			:: true;
			fi
		};
		
		if
		:: lb_for244_4 != -1 && ub_for244_5 != -1 -> 
						for(i : lb_for244_4.. ub_for244_5) {
for22:				do
				:: quitCh.async_rcv?0 -> 
					goto stop_process
				:: quitCh.sync?0 -> 
					goto stop_process
				:: true;
				:: txCh.async_rcv?0 -> 
					break
				:: txCh.sync?0 -> 
					break
				od
			}
		:: else -> 
			do
			:: true -> 
for22:				do
				:: quitCh.async_rcv?0 -> 
					goto stop_process
				:: quitCh.sync?0 -> 
					goto stop_process
				:: true;
				:: txCh.async_rcv?0 -> 
					break
				:: txCh.sync?0 -> 
					break
				od
			:: true -> 
				break
			od
		fi;
for22_exit:
	};
for20_exit:
stop_process:}

proctype Anonymous0(Chandef chainHeadCh;Chandef txEventCh;Chandef quitCh;Chandef headCh;Chandef txCh) {
	bool closed; 
	int i;
HandleLoop:		do
	:: true -> 
for10:		do
		:: txEventCh.async_rcv?0 -> 
			do
			:: txCh.async_send!0 -> 
				break
			:: txCh.sync!0 -> 
				txCh.sending?0;
				break
			:: true -> 
				break
			od;
			break
		:: txEventCh.sync?0 -> 
			do
			:: txCh.async_send!0 -> 
				break
			:: txCh.sync!0 -> 
				txCh.sending?0;
				break
			:: true -> 
				break
			od;
			break
		:: true -> 
			goto HandleLoop
		:: true -> 
			goto HandleLoop
		od
	od;
for10_exit:;
	quitCh.closing!true;
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

