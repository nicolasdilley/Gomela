#define lb_for81_0  -1
#define ub_for81_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example485166879/st/library/fromEmail.go
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
	Chandef poll;
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		poll.size = 1;
		run emptyChan(poll)
	:: else -> 
		run sync_monitor(poll)
	fi;
	
	if
	:: poll.async_send!0;
	:: poll.sync!0 -> 
		poll.sending?0
	fi;
		for(i : lb_for81_0.. ub_for81_1) {
for10:		do
		:: poll.async_rcv?0 -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					chan child_librarysleep0 = [0] of {int};
					run librarysleep(poll,child_librarysleep0);
					child_librarysleep0?0
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					chan child_librarysleep1 = [0] of {int};
					run librarysleep(poll,child_librarysleep1);
					child_librarysleep1?0;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					chan child_librarysleep2 = [0] of {int};
					run librarysleep(poll,child_librarysleep2);
					child_librarysleep2?0;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					chan child_librarysleep3 = [0] of {int};
					run librarysleep(poll,child_librarysleep3);
					child_librarysleep3?0;
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			chan child_librarysleep4 = [0] of {int};
			run librarysleep(poll,child_librarysleep4);
			child_librarysleep4?0;
			break
		:: poll.sync?0 -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					chan child_librarysleep0 = [0] of {int};
					run librarysleep(poll,child_librarysleep0);
					child_librarysleep0?0
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					chan child_librarysleep1 = [0] of {int};
					run librarysleep(poll,child_librarysleep1);
					child_librarysleep1?0;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					chan child_librarysleep2 = [0] of {int};
					run librarysleep(poll,child_librarysleep2);
					child_librarysleep2?0;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					chan child_librarysleep3 = [0] of {int};
					run librarysleep(poll,child_librarysleep3);
					child_librarysleep3?0;
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			chan child_librarysleep4 = [0] of {int};
			run librarysleep(poll,child_librarysleep4);
			child_librarysleep4?0;
			break
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
			fi
		od
	};
for10_exit:
stop_process:}

proctype librarysleep(Chandef poll;chan child) {
	bool closed; 
	int i;
	run Anonymous1(poll);
	child!0;
stop_process:
}
proctype Anonymous1(Chandef poll) {
	bool closed; 
	int i;
	
	if
	:: poll.async_send!0;
	:: poll.sync!0 -> 
		poll.sending?0
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

