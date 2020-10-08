#define lb_for492_0  -1
#define ub_for492_1  -1
#define lb_for431_2  -1
#define ub_for431_3  -1
#define lb_for452_4  -1
#define ub_for452_5  -1
#define lb_for515_6  -1
#define ub_for515_7  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example975343204/cli/cmd/top.go
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
	Chandef done;
	Chandef requestCh;
	chan child_cmdrenderTable0 = [0] of {int};
	Chandef eventCh;
	Chandef closing;
	Chandef horizontalScroll;
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
	run sync_monitor(eventCh);
	
	if
	:: 100 > 0 -> 
		requestCh.size = 100;
		run emptyChan(requestCh)
	:: else -> 
		run sync_monitor(requestCh)
	fi;
	
	if
	:: 1 > 0 -> 
		closing.size = 1;
		run emptyChan(closing)
	:: else -> 
		run sync_monitor(closing)
	fi;
	run sync_monitor(done);
	run sync_monitor(horizontalScroll);
	run go_cmdpollInput(done,horizontalScroll);
	run go_cmdrecvEvents(eventCh,closing);
	run go_cmdprocessEvents(eventCh,requestCh,done);
	run Anonymous3(eventCh,requestCh,closing,done,horizontalScroll);
	run cmdrenderTable(requestCh,done,horizontalScroll,child_cmdrenderTable0);
	child_cmdrenderTable0?0;
	goto stop_process
stop_process:}

proctype go_cmdpollInput(Chandef done;Chandef horizontalScroll) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		

		if
		:: true -> 
			
			if
			:: true -> 
				done.closing!true;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: horizontalScroll.async_send!0;
				:: horizontalScroll.sync!0 -> 
					horizontalScroll.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: horizontalScroll.async_send!0;
				:: horizontalScroll.sync!0 -> 
					horizontalScroll.sending?0
				fi
			:: true;
			fi
		fi
	od;
for10_exit:stop_process:
}
proctype go_cmdrecvEvents(Chandef eventCh;Chandef closing) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			
			if
			:: closing.async_send!0;
			:: closing.sync!0 -> 
				closing.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: eventCh.async_send!0;
		:: eventCh.sync!0 -> 
			eventCh.sending?0
		fi
	od;
for20_exit:stop_process:
}
proctype go_cmdprocessEvents(Chandef eventCh;Chandef requestCh;Chandef done) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		do
		:: done.async_rcv?0 -> 
			goto stop_process
		:: done.sync?0 -> 
			goto stop_process
		od
	od;
for30_exit:stop_process:
}
proctype Anonymous3(Chandef eventCh;Chandef requestCh;Chandef closing;Chandef done;Chandef horizontalScroll) {
	bool closed; 
	int i;
	
	if
	:: closing.async_rcv?0;
	:: closing.sync?0;
	fi;
stop_process:
}
proctype cmdrenderTable(Chandef requestCh;Chandef done;Chandef horizontalScroll;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for40:		do
		:: done.async_rcv?0 -> 
			goto stop_process
		:: done.sync?0 -> 
			goto stop_process
		:: true;
		od
	od;
for40_exit:	child!0;
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

