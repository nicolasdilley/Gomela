#define handleClient_maxchan  3
#define lb_for69_1  -1
#define ub_for69_2  -1

// /tmp/clone-example743352769/src/stats/main.go
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
	Chandef ch;
	int i;
	int maxchan = handleClient_maxchan;
	bool state = false;
	
	if
	:: maxchan > 0 -> 
		ch.size = maxchan;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run go_mainStatsAgent(ch);
	do
	:: true -> 
for20:		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi
	od;
for20_exit:	ch.closing!true
stop_process:}

proctype go_mainStatsAgent(Chandef incoming) {
	bool closed; 
	int i;
	bool state;
	Chandef queue_timer;
	
	if
	:: 1 > 0 -> 
		queue_timer.size = 1;
		run AsyncChan(queue_timer)
	:: else -> 
		run sync_monitor(queue_timer)
	fi;
	
	if
	:: queue_timer.async_send!0;
	:: queue_timer.sync!0 -> 
		queue_timer.sending?0
	fi;
	do
	:: true -> 
for10:		do
		:: incoming.async_rcv?0 -> 
			break
		:: incoming.sync?0 -> 
			break
		:: queue_timer.async_rcv?0 -> 
			break
		:: queue_timer.sync?0 -> 
			break
		od
	od;
for10_exit:stop_process:
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

