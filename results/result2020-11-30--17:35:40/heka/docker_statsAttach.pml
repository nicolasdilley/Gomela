#define lb_for207_0  -1
#define ub_for207_1  -1

// /tmp/clone-example569798719/plugins/docker/stats_handling.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	int i;
	Chandef statsrd;
	Chandef done;
	Chandef failure;
	bool state = false;
	run sync_monitor(done);
	run sync_monitor(statsrd);
	run sync_monitor(failure);
	run Anonymous0(done,statsrd,failure);
		for(i : lb_for207_0.. ub_for207_1) {
for10:		
		if
		:: true -> 
			break
		:: true;
		fi;
		chan child_dockerNewStatsPump0 = [0] of {int};
		run dockerNewStatsPump(statsrd,child_dockerNewStatsPump0);
		child_dockerNewStatsPump0?0;
		goto stop_process
	};
for10_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef done;Chandef statsrd;Chandef failure) {
	bool closed; 
	int i;
	bool state;
	done.closing!true;
	
	if
	:: true -> 
		
		if
		:: failure.async_send!0;
		:: failure.sync!0 -> 
			failure.sending?0
		fi
	:: true;
	fi;
stop_process:
}
proctype dockerNewStatsPump(Chandef statsChan;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
stop_process:	child!0
}
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
		  :: ch.sending!false;  // sending channel is open
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}
