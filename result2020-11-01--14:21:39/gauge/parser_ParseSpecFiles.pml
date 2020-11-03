#define ParseSpecFiles_limit 3
#define ParseSpecFiles_r_parseResult_ParseErrors 0
#define lb_for58_2  -1
#define ub_for58_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example015883625/parser/parse.go
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
	int limit = ParseSpecFiles_limit;
	Chandef piChan;
	int r_parseResult_ParseErrors = ParseSpecFiles_r_parseResult_ParseErrors;
	bool state = false;
	run sync_monitor(piChan);
	run go_parserparseSpecFiles(piChan,limit);
	do
	:: piChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: piChan.async_rcv?0;
			:: piChan.sync?0;
			fi;
			
			if
			:: true -> 
								for(i : 0.. r_parseResult_ParseErrors-1) {
for21:
				}
			:: true;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype go_parserparseSpecFiles(Chandef piChan;int limit) {
	bool closed; 
	int i;
	bool state;
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. limit-1) {
for10:		wg.Add!1;
		run go_parserparse(wg,piChan)
	};
for10_exit:	wg.Wait?0;
	piChan.closing!true;
stop_process:
}
proctype go_parserparse(Wgdef wg;Chandef piChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for11:		
		if
		:: true -> 
			
			if
			:: piChan.async_send!0;
			:: piChan.sync!0 -> 
				piChan.sending?0
			fi
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	od;
for11_exit:stop_process:	wg.Add!-1
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


