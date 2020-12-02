#define lb_for63_0  -1
#define ub_for63_1  -1
#define lb_for86_2  -1
#define ub_for86_3  -1

// /tmp/clone-example470496538/go/configuration/configuration.go
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
	Chandef updates;
	int i;
	Chandef req;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		updates.size = 1;
		run AsyncChan(updates)
	:: else -> 
		run sync_monitor(updates)
	fi;
	run sync_monitor(req);
	run Anonymous0(updates,req);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef updates;Chandef req) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for63_0 != -2 && ub_for63_1 != -2 -> 
				for(i : lb_for63_0.. ub_for63_1) {
for10:			
			if
			:: true -> 
				
				if
				:: updates.async_send!0;
				:: updates.sync!0 -> 
					updates.sending?0
				fi
			:: true;
			fi;
			break
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				
				if
				:: updates.async_send!0;
				:: updates.sync!0 -> 
					updates.sending?0
				fi
			:: true;
			fi;
			break
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		
		if
		:: updates.async_send!0;
		:: updates.sync!0 -> 
			updates.sending?0
		fi
	:: true -> 
		
		if
		:: updates.async_send!0;
		:: updates.sync!0 -> 
			updates.sending?0
		fi
	:: true -> 
		
		if
		:: updates.async_send!0;
		:: updates.sync!0 -> 
			updates.sending?0
		fi
	fi;
	
	if
	:: lb_for86_2 != -2 && ub_for86_3 != -2 -> 
				for(i : lb_for86_2.. ub_for86_3) {
for20:			
			if
			:: req.async_rcv?0;
			:: req.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: updates.async_send!0;
				:: updates.sync!0 -> 
					updates.sending?0
				fi
			:: true;
			fi;
			
			if
			:: updates.async_send!0;
			:: updates.sync!0 -> 
				updates.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: req.async_rcv?0;
			:: req.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: updates.async_send!0;
				:: updates.sync!0 -> 
					updates.sending?0
				fi
			:: true;
			fi;
			
			if
			:: updates.async_send!0;
			:: updates.sync!0 -> 
				updates.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:stop_process:
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

