#define lb_for271_0  -1
#define ub_for271_1  -1
#define lb_for15_2  -1
#define ub_for15_3  -1
#define lb_for186_4  -1
#define ub_for186_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example856946014/peer/peer.go
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
	int alpha = 5;
	Chandef out;
	Chandef canWrite;
	Chandef pr_props;
	int i;
	Chandef in;
	Chandef pr_seqns;
	Chandef shun;
	int shun = 5;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		canWrite.size = 1;
		run emptyChan(canWrite)
	:: else -> 
		run sync_monitor(canWrite)
	fi;
	
	if
	:: 50 > 0 -> 
		in.size = 50;
		run emptyChan(in)
	:: else -> 
		run sync_monitor(in)
	fi;
	
	if
	:: 50 > 0 -> 
		out.size = 50;
		run emptyChan(out)
	:: else -> 
		run sync_monitor(out)
	fi;
	
	if
	:: 50 > 0 -> 
		pr_seqns.size = 50;
		run emptyChan(pr_seqns)
	:: else -> 
		run sync_monitor(pr_seqns)
	fi;
	run sync_monitor(pr_props);
	
	if
	:: true -> 
		
		if
		:: 0 != -1 && alpha-1 != -1 -> 
						for(i : 0.. alpha-1) {
for10:
			}
		:: else -> 
			do
			:: true -> 
for10:
			:: true -> 
				break
			od
		fi;
for10_exit:		
		if
		:: canWrite.async_send!0;
		:: canWrite.sync!0 -> 
			canWrite.sending?0
		fi
	:: true -> 
		Chandef stop;
		
		if
		:: 1 > 0 -> 
			stop.size = 1;
			run emptyChan(stop)
		:: else -> 
			run sync_monitor(stop)
		fi;
		run go_peerfollow(stop);
		Chandef errs;
		run sync_monitor(errs);
		run Anonymous1(canWrite,in,out,stop,errs,shun);
		errs.closing!true;
		run Anonymous2(canWrite,in,out,stop,errs,shun)
	:: true -> 
		Chandef stop;
		
		if
		:: 1 > 0 -> 
			stop.size = 1;
			run emptyChan(stop)
		:: else -> 
			run sync_monitor(stop)
		fi;
		run go_peerfollow(stop);
		Chandef errs;
		run sync_monitor(errs);
		run Anonymous1(canWrite,in,out,stop,errs,shun);
		errs.closing!true;
		run Anonymous2(canWrite,in,out,stop,errs,shun)
	fi;
	
	if
	:: 3 > 0 -> 
		shun.size = 3;
		run emptyChan(shun)
	:: else -> 
		run sync_monitor(shun)
	fi;
	run go_memberClean(shun,shun);
	run go_serverListenAndServe(canWrite);
	run Anonymous6(canWrite,in,out,stop,errs,shun);
	do
	:: true -> 
for60:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: in.async_send!0;
		:: in.sync!0 -> 
			in.sending?0
		fi
	od;
for60_exit:
stop_process:}

proctype go_peerfollow(Chandef stop) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: stop.async_rcv?0 -> 
			goto stop_process
		:: stop.sync?0 -> 
			goto stop_process
		:: true -> 
			break
		od
	od;
for20_exit:stop_process:
}
proctype Anonymous1(Chandef canWrite;Chandef in;Chandef out;Chandef stop;Chandef errs;Chandef shun) {
	bool closed; 
	int i;
	
	if
	:: errs.async_rcv?0;
	:: errs.sync?0;
	fi;
stop_process:
}
proctype Anonymous2(Chandef canWrite;Chandef in;Chandef out;Chandef stop;Chandef errs;Chandef shun) {
	bool closed; 
	int i;
	
	if
	:: stop.async_send!0;
	:: stop.sync!0 -> 
		stop.sending?0
	fi;
	
	if
	:: canWrite.async_send!0;
	:: canWrite.sync!0 -> 
		canWrite.sending?0
	fi;
stop_process:
}
proctype go_memberClean(Chandef c;int c) {
	bool closed; 
	int i;
	do
	:: c.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: c.async_rcv?0;
			:: c.sync?0;
			fi;
			
			if
			:: true -> 
				run Anonymous4(c)
			:: true;
			fi
		fi
	od;
stop_process:
}
proctype Anonymous4(Chandef c) {
	bool closed; 
	int i;
stop_process:
}
proctype go_serverListenAndServe(Chandef canWrite) {
	bool closed; 
	int i;
		for(i : lb_for15_2.. ub_for15_3) {
for40:		
		if
		:: true -> 
			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true;
		fi;
		do
		:: true -> 
			break
		od
	};
for40_exit:stop_process:
}
proctype Anonymous6(Chandef canWrite;Chandef in;Chandef out;Chandef stop;Chandef errs;Chandef shun) {
	bool closed; 
	int i;
	do
	:: out.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: out.async_rcv?0;
			:: out.sync?0;
			fi
		fi
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

