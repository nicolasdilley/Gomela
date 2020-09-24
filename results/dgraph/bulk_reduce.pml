#define 2 * cpu  5
#define 2 * cpu  5
#define lb_for502_2  -1
#define ub_for502_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example201344943/dgraph/cmd/bulk/reduce.go
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
	Chandef encoderCh;
	int writerCh = 5;
	int cpu = 5;
	int i;
	Chandef writerCh;
	int encoderCh = 5;
	int keys = 5;
	bool state = false;
	
	if
	:: 2 * cpu > 0 -> 
		encoderCh.size = 2 * cpu;
		run emptyChan(encoderCh)
	:: else -> 
		run sync_monitor(encoderCh)
	fi;
	
	if
	:: 2 * cpu > 0 -> 
		writerCh.size = 2 * cpu;
		run emptyChan(writerCh)
	:: else -> 
		run sync_monitor(writerCh)
	fi;
		for(i : 0.. cpu-1) {
for10:		run go_rencode(encoderCh,encoderCh)
	};
for10_exit:	run go_rstartWriting(writerCh,writerCh);
	
	if
	:: 0 != -1 && partitionKeys-1 != -1 -> 
				for(i : 0.. partitionKeys-1) {
for30:			do
			:: true -> 
for31:
			:: true -> 
				break
			od;
			do
			:: true;
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				
				if
				:: lb_for502_2 != -1 && ub_for502_3 != -1 -> 
										for(i : lb_for502_2.. ub_for502_3) {
for32:
					}
				:: else -> 
					do
					:: true -> 
for32:
					:: true -> 
						break
					od
				fi;
for32_exit:				do
				:: true -> 
for33:
				:: true -> 
					break
				od
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			do
			:: true -> 
for31:
			:: true -> 
				break
			od;
			do
			:: true;
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				
				if
				:: lb_for502_2 != -1 && ub_for502_3 != -1 -> 
										for(i : lb_for502_2.. ub_for502_3) {
for32:
					}
				:: else -> 
					do
					:: true -> 
for32:
					:: true -> 
						break
					od
				fi;
for32_exit:				do
				:: true -> 
for33:
				:: true -> 
					break
				od
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	do
	:: true -> 
for40:
	:: true -> 
		break
	od;
	encoderCh.closing!true;
	writerCh.closing!true
stop_process:}

proctype go_rencode(Chandef entryCh;int entryCh) {
	bool closed; 
	int i;
	do
	:: entryCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			entryCh.in?0
		fi
	od;
stop_process:
}
proctype go_rstartWriting(Chandef writerCh;int writerCh) {
	bool closed; 
	int i;
	do
	:: writerCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			writerCh.in?0;
			run Anonymous2(writerCh);
			do
			:: true -> 
for22:
			:: true -> 
				break
			od
		fi
	od;
stop_process:
}
proctype Anonymous2(Chandef writerCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for21:
	:: true -> 
		break
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

