#define Read_inbox_ConvsUnverified  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example695274255/go/chat/inboxsource.go
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
	int inbox_ConvsUnverified = Read_inbox_ConvsUnverified;
	Chandef localizeCb;
	bool state = false;
	chan child_screateConversationLocalizer3 = [0] of {int};
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
	:: inbox_ConvsUnverified + 1 > 0 -> 
		localizeCb.size = inbox_ConvsUnverified + 1;
		run emptyChan(localizeCb)
	:: else -> 
		run sync_monitor(localizeCb)
	fi;
	run screateConversationLocalizer(localizeCb,child_screateConversationLocalizer0);
	child_screateConversationLocalizer3?0;
	
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

proctype screateConversationLocalizer(Chandef localizeCb;chan child) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		chan child_chatnewBlockingLocalizer0 = [0] of {int};
		run chatnewBlockingLocalizer(localizeCb,child_chatnewBlockingLocalizer0);
		child_chatnewBlockingLocalizer0?0;
		goto stop_process
	:: true -> 
		chan child_chatnewNonblockingLocalizer1 = [0] of {int};
		run chatnewNonblockingLocalizer(localizeCb,child_chatnewNonblockingLocalizer1);
		child_chatnewNonblockingLocalizer1?0;
		goto stop_process
	:: true -> 
		chan child_chatnewBlockingLocalizer2 = [0] of {int};
		run chatnewBlockingLocalizer(localizeCb,child_chatnewBlockingLocalizer2);
		child_chatnewBlockingLocalizer2?0;
		goto stop_process
	fi;
	child!0;
stop_process:
}
proctype chatnewBlockingLocalizer(Chandef localizeCb;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
	child!0;
stop_process:
}
proctype chatnewNonblockingLocalizer(Chandef localizeCb;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
	child!0;
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

