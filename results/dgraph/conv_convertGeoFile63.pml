
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example913407792/dgraph/cmd/conv/conv.go
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
	Chandef chb;
	bool state = false;
	int f_Properties = -2;
	Chandef che;
	int fc_Features = -2;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		che.size = 1;
		run AsyncChan(che)
	:: else -> 
		run sync_monitor(che)
	fi;
	
	if
	:: 1000 > 0 -> 
		chb.size = 1000;
		run AsyncChan(chb)
	:: else -> 
		run sync_monitor(chb)
	fi;
	run Anonymous0(che,chb);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. fc_Features-1) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: chb.async_send!0;
		:: chb.sync!0 -> 
			chb.sending?0
		fi;
				for(i : 0.. f_Properties-1) {
for21:			
			if
			:: true -> 
				
				if
				:: chb.async_send!0;
				:: chb.sync!0 -> 
					chb.sending?0
				fi
			:: true;
			fi
		}
	};
	chb.closing!true;
	
	if
	:: che.async_rcv?0;
	:: che.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef che;Chandef chb) {
	bool closed; 
	int i;
	bool state;
	chan child_convwriteToFile0 = [0] of {int};
	run convwriteToFile(chb,child_convwriteToFile0);
	child_convwriteToFile0?0;
	
	if
	:: che.async_send!0;
	:: che.sync!0 -> 
		che.sending?0
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

