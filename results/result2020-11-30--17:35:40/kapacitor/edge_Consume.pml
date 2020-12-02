#define Consume_c_ins  3
#define lb_for156_1  -1
#define ub_for156_2  -1

// /tmp/clone-example660668482/edge/consumer.go
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
	Chandef firstErr;
	Chandef errC;
	int c_ins = Consume_c_ins;
	bool state = false;
	
	if
	:: c_ins > 0 -> 
		errC.size = c_ins;
		run AsyncChan(errC)
	:: else -> 
		run sync_monitor(errC)
	fi;
	
	if
	:: 1 > 0 -> 
		firstErr.size = 1;
		run AsyncChan(firstErr)
	:: else -> 
		run sync_monitor(firstErr)
	fi;
	run Anonymous1(errC,firstErr);
LOOP:		do
	:: true -> 
for30:		do
		od
	od;
for30_exit:;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errC;Chandef firstErr) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: errC.async_send!0;
	:: errC.sync!0 -> 
		errC.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef errC;Chandef firstErr) {
	bool closed; 
	int i;
	bool state;
		for(i : 0.. c_ins-1) {
for20:		
		if
		:: errC.async_rcv?0;
		:: errC.sync?0;
		fi;
		
		if
		:: true -> 
			
			if
			:: firstErr.async_send!0;
			:: firstErr.sync!0 -> 
				firstErr.sending?0
			fi
		:: true;
		fi
	};
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

