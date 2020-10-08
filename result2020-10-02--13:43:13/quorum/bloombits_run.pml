#define lb_for409_0  -1
#define ub_for409_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example933794056/core/bloombits/matcher.go
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
	Chandef dist;
	int i;
	int m_filters = 5;
	Chandef source;
	int m_sectionSize = 5;
	int bloom = 5;
	bool state = false;
	
	if
	:: buffer > 0 -> 
		source.size = buffer;
		run emptyChan(source)
	:: else -> 
		run sync_monitor(source)
	fi;
	run Anonymous0(source,dist);
	
	if
	:: buffer > 0 -> 
		dist.size = buffer;
		run emptyChan(dist)
	:: else -> 
		run sync_monitor(dist)
	fi;
		for(i : 1.. m_filters) {
for20:
	};
	run go_mdistributor(dist);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef source;Chandef dist) {
	bool closed; 
	int i;
	
	if
	:: begin / m_sectionSize != -1 && end / m_sectionSize != -1 -> 
				for(i : begin / m_sectionSize.. end / m_sectionSize) {
for10:			do
			:: true -> 
				goto stop_process
			:: source.async_send!0 -> 
				break
			:: source.sync!0 -> 
				source.sending?0;
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				goto stop_process
			:: source.async_send!0 -> 
				break
			:: source.sync!0 -> 
				source.sending?0;
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	source.closing!true;
stop_process:
}
proctype go_mdistributor(Chandef dist) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		do
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			goto stop_process
		od
	od;
for30_exit:stop_process:
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

