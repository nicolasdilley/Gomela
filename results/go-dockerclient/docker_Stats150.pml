#define lb_for207_0  -1
#define ub_for207_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example343059594/container_stats.go
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
	Chandef reqSent;
	Chandef errC;
	Chandef quit;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		errC.size = 1;
		run AsyncChan(errC)
	:: else -> 
		run sync_monitor(errC)
	fi;
	run sync_monitor(reqSent);
	run Anonymous0(errC,reqSent,quit);
	run sync_monitor(quit);
	run Anonymous1(errC,reqSent,quit);
	
	if
	:: reqSent.async_rcv?0;
	:: reqSent.sync?0;
	fi;
	
	if
	:: lb_for207_0 != -2 && ub_for207_1 != -2 -> 
				for(i : lb_for207_0.. ub_for207_1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process;
	quit.closing!true;
	
	if
	:: errC.async_rcv?0;
	:: errC.sync?0;
	fi
stop_process:}

proctype Anonymous0(Chandef errC;Chandef reqSent;Chandef quit) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: errC.async_send!0;
	:: errC.sync!0 -> 
		errC.sending?0
	fi;
stop_process:	errC.closing!true
}
proctype Anonymous1(Chandef errC;Chandef reqSent;Chandef quit) {
	bool closed; 
	int i;
	bool state;
	do
	:: quit.async_rcv?0 -> 
		goto stop_process
	:: quit.sync?0 -> 
		goto stop_process
	od;
stop_process:
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

