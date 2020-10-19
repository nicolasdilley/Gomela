#define list_driverNames  60
#define list_all  60
#define list_dls  60
#define list_vs  60
#define list_s_names  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example692551345/volume/service/store.go
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
	int dls = list_dls;
	int driverNames = list_driverNames;
	int s_names = list_s_names;
	Chandef chVols;
	int all = list_all;
	int vs = list_vs;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 1.. driverNames) {
for10:
		};
				for(i : 1.. all) {
for20:
		}
	:: true -> 
				for(i : 1.. driverNames) {
for10:
		};
				for(i : 1.. all) {
for20:
		}
	fi;
	
	if
	:: dls > 0 -> 
		chVols.size = dls;
		run emptyChan(chVols)
	:: else -> 
		run sync_monitor(chVols)
	fi;
		for(i : 1.. dls) {
for30:		run Anonymous0(chVols)
	};
	
	if
	:: 0 != -1 && dls-1 != -1 -> 
				for(i : 0.. dls-1) {
for40:			
			if
			:: chVols.async_rcv?0;
			:: chVols.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for40:			
			if
			:: chVols.async_rcv?0;
			:: chVols.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for40_exit:	
	if
	:: true -> 
				for(i : 1.. s_names) {
for50:
		}
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef chVols) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: chVols.async_send!0;
		:: chVols.sync!0 -> 
			chVols.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
		for(i : 1.. vs) {
for31:
	};
	
	if
	:: chVols.async_send!0;
	:: chVols.sync!0 -> 
		chVols.sending?0
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

