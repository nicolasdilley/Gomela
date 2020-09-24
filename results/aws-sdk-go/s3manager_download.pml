#define d_cfg_Concurrency  5
#define lb_for362_1  -1
#define ub_for362_2  -1
#define lb_for321_3  -1
#define ub_for321_4  -1
#define lb_for336_5  -1
#define ub_for336_6  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example960179689/service/s3/s3manager/download.go
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
	int d_cfg_Concurrency = 5;
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		Chandef ch;
		
		if
		:: d_cfg_Concurrency > 0 -> 
			ch.size = d_cfg_Concurrency;
			run emptyChan(ch)
		:: else -> 
			run sync_monitor(ch)
		fi;
				for(i : 0.. d_cfg_Concurrency-1) {
for10:			run go_ddownloadPart(ch)
		};
for10_exit:		
		if
		:: lb_for321_3 != -1 && ub_for321_4 != -1 -> 
						for(i : lb_for321_3.. ub_for321_4) {
for20:				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi
			}
		:: else -> 
			do
			:: true -> 
for20:				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi
			:: true -> 
				break
			od
		fi;
for20_exit:		ch.closing!true
	:: true -> 
		
		if
		:: lb_for336_5 != -1 && ub_for336_6 != -1 -> 
						for(i : lb_for336_5.. ub_for336_6) {
for30:
			}
		:: else -> 
			do
			:: true -> 
for30:
			:: true -> 
				break
			od
		fi;
for30_exit:
	:: true -> 
		
		if
		:: lb_for336_5 != -1 && ub_for336_6 != -1 -> 
						for(i : lb_for336_5.. ub_for336_6) {
for30:
			}
		:: else -> 
			do
			:: true -> 
for30:
			:: true -> 
				break
			od
		fi;
for30_exit:
	fi;
	goto stop_process
stop_process:}

proctype go_ddownloadPart(Chandef ch) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		
		if
		:: ch.async_rcv?0;
		:: ch.sync?0;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for11_exit:stop_process:
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

