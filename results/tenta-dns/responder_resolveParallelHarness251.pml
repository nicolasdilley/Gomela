#define resolveParallelHarness_input  ??
#define lb_for287_1  -1
#define ub_for287_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example070518908/responder/recursive_dns_resolver.go
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
	int answer_Answer = -2;
	bool state = false;
	int t_Answer = -2;
	Chandef achan;
	int input = resolveParallelHarness_input;
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
								for(i : 0.. answer_Answer-1) {
for20:
				}
			:: true;
			fi
		:: true;
		fi;
		goto stop_process
	fi;
	
	if
	:: input > 0 -> 
		achan.size = input;
		run AsyncChan(achan)
	:: else -> 
		run sync_monitor(achan)
	fi;
	do
	:: true -> 
for40:		
		if
		:: true -> 
			break
		:: true;
		fi;
		do
		:: achan.async_rcv?0 -> 
			
			if
			:: true -> 
								for(i : 0.. t_Answer-1) {
for41:
				}
			:: true;
			fi;
			break
		:: achan.sync?0 -> 
			
			if
			:: true -> 
								for(i : 0.. t_Answer-1) {
for41:
				}
			:: true;
			fi;
			break
		:: true -> 
			goto for41_exit
		od
	od;
for40_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef achan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: achan.async_send!0;
	:: achan.sync!0 -> 
		achan.sending?0
	fi;
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

