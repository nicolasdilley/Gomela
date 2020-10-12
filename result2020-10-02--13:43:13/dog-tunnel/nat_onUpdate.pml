#define lb_for150_0  -1
#define ub_for150_1  -1
#define lb_for227_2  -1
#define ub_for227_3  -1
#define lb_for259_4  -1
#define ub_for259_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example576214507/nat/connection.go
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
	int c_fecRCacheTbl = 5;
	Chandef ping;
	int c_fecDataShards = 5;
	Chandef recvChan;
	Chandef recoverChan;
	int tbl_bytes = 5;
	int waitList = 5;
	bool state = false;
	run sync_monitor(recvChan);
	run Anonymous0(recvChan,ping,recoverChan);
	run sync_monitor(ping);
	run sync_monitor(recoverChan);
	run Anonymous1(recvChan,ping,recoverChan);
out:			for(i : lb_for227_2.. ub_for227_3) {
for20:		do
		:: ping.async_rcv?0 -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
										for(i : 1.. c_fecRCacheTbl) {
for21:
					}
				:: true;
				fi
			:: true;
			fi;
			break
		:: ping.sync?0 -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
										for(i : 1.. c_fecRCacheTbl) {
for21:
					}
				:: true;
				fi
			:: true;
			fi;
			break
		:: recoverChan.async_rcv?0 -> 
						for(i : 1.. waitList) {
for27:				do
				:: true;
				:: true;
				od
			};
			break
		:: recoverChan.sync?0 -> 
						for(i : 1.. waitList) {
for27:				do
				:: true;
				:: true;
				od
			};
			break
		:: true -> 
			
			if
			:: true -> 
				goto out
			:: true;
			fi
		:: true -> 
			goto out
		od
	};
for20_exit:
stop_process:}

proctype Anonymous0(Chandef recvChan;Chandef ping;Chandef recoverChan) {
	bool closed; 
	int i;
		for(i : lb_for150_0.. ub_for150_1) {
for10:		
		if
		:: true -> 
			
			if
			:: true -> 
				break
			:: true -> 
				break
			fi
		:: true;
		fi;
		do
		:: recvChan.async_send!0 -> 
			break
		:: recvChan.sync!0 -> 
			recvChan.sending?0;
			break
		:: true -> 
			goto stop_process
		od
	};
for10_exit:stop_process:
}
proctype Anonymous1(Chandef recvChan;Chandef ping;Chandef recoverChan) {
	bool closed; 
	int i;
	do
	:: ping.async_send!0 -> 
		break
	:: ping.sync!0 -> 
		ping.sending?0;
		break
	:: true;
	od;
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
