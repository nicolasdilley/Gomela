
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example037776124/carver.go
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
	int c_Height = -2;
	int faces = -2;
	bool state = false;
	int c_Width = -2;
	int i;
	
	if
	:: true -> 
				for(i : 0.. faces-1) {
for20:
		};
		Chandef c;
		
		if
		:: 2 > 0 -> 
			c.size = 2;
			run AsyncChan(c)
		:: else -> 
			run sync_monitor(c)
		fi;
		do
		:: c!0 -> 
			break
		:: true -> 
			break
		od;
		run Anonymous0(c)
	:: true;
	fi;
	
	if
	:: 0 != -2 && c_Width-1 != -3 -> 
				for(i : 0.. c_Width-1) {
for40:for41_exit:
		}
	:: else -> 
		do
		:: true -> 
for40:for41_exit:
		:: true -> 
			break
		od
	fi;
for40_exit:	
	if
	:: 1 != -2 && c_Height-1 != -3 -> 
				for(i : 1.. c_Height-1) {
for50:for51_exit:
		}
	:: else -> 
		do
		:: true -> 
for50:for51_exit:
		:: true -> 
			break
		od
	fi;
for50_exit:
stop_process:}

proctype Anonymous0(Chandef c) {
	bool closed; 
	int i;
	bool state;
	do
	:: c.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: c.async_rcv?0;
			:: c.sync?0;
			fi
		fi
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

