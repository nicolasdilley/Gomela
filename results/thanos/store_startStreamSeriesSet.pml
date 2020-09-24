#define lb_for394_0  -1
#define ub_for394_1  -1
#define lb_for404_2  -1
#define ub_for404_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example169698551/pkg/store/proxy.go
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
	int i;
	Chandef s_recvCh;
	bool state = false;
	
	if
	:: 10 > 0 -> 
		s_recvCh.size = 10;
		run emptyChan(s_recvCh)
	:: else -> 
		run sync_monitor(s_recvCh)
	fi;
	run Anonymous0();
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
			goto stop_process
		:: true;
		od
	od;
for10_exit:stop_process:
}
proctype shandleErr(Chandef done;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	done.closing!true;
	child!0;
stop_process:
}
proctype Anonymous0() {
	bool closed; 
	int i;
	Chandef rCh;
	Chandef done;
	run sync_monitor(rCh);
	run sync_monitor(done);
	run Anonymous0();
	do
	:: true -> 
for20:		do
		:: true -> 
			chan child_shandleErr0 = [0] of {int};
			run shandleErr(done,child_shandleErr0);
			child_shandleErr0?0;
			goto stop_process
		:: true -> 
			chan child_shandleErr1 = [0] of {int};
			run shandleErr(done,child_shandleErr1);
			child_shandleErr1?0;
			goto stop_process
		od;
		
		if
		:: true -> 
			done.closing!true;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			chan child_shandleErr2 = [0] of {int};
			run shandleErr(done,child_shandleErr2);
			child_shandleErr2?0;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			do
			:: true;
			:: true -> 
				chan child_shandleErr3 = [0] of {int};
				run shandleErr(done,child_shandleErr3);
				child_shandleErr3?0;
				goto stop_process
			od
		:: true;
		fi
	od;
for20_exit:stop_process:
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

