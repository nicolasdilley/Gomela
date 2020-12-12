#define Start_s_AllowedPendingMessages  ??
#define Start_s_MaxTCPConnections  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example359059926/plugins/inputs/statsd/statsd.go
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
	Chandef s_done;
	int i;
	int s_AllowedPendingMessages = Start_s_AllowedPendingMessages;
	Chandef s_in;
	Chandef s_accept;
	int s_MaxTCPConnections = Start_s_MaxTCPConnections;
	bool state = false;
	
	if
	:: s_AllowedPendingMessages > 0 -> 
		s_in.size = s_AllowedPendingMessages;
		run AsyncChan(s_in)
	:: else -> 
		run sync_monitor(s_in)
	fi;
	run sync_monitor(s_done);
	
	if
	:: s_MaxTCPConnections > 0 -> 
		s_accept.size = s_MaxTCPConnections;
		run AsyncChan(s_accept)
	:: else -> 
		run sync_monitor(s_accept)
	fi;
	
	if
	:: 0 != -2 && s_MaxTCPConnections-1 != -3 -> 
				for(i : 0.. s_MaxTCPConnections-1) {
for10:			
			if
			:: s_accept.async_send!0;
			:: s_accept.sync!0 -> 
				s_accept.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: s_accept.async_send!0;
			:: s_accept.sync!0 -> 
				s_accept.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run Anonymous0(s_in,s_done,s_accept)
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run Anonymous1(s_in,s_done,s_accept)
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run Anonymous1(s_in,s_done,s_accept)
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef s_in;Chandef s_done;Chandef s_accept) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous1(Chandef s_in;Chandef s_done;Chandef s_accept) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous2(Chandef s_in;Chandef s_done;Chandef s_accept) {
	bool closed; 
	int i;
	bool state;
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

