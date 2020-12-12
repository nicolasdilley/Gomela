
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example135141040/app/webhook.go
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
	bool state = false;
	Chandef uchan;
	Chandef hchan;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		hchan.size = 1;
		run AsyncChan(hchan)
	:: else -> 
		run sync_monitor(hchan)
	fi;
	run Anonymous0(hchan,uchan,cchan,cchan);
	
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
	
	if
	:: true -> 
		goto stop_process
	fi;
	
	if
	:: 1 > 0 -> 
		uchan.size = 1;
		run AsyncChan(uchan)
	:: else -> 
		run sync_monitor(uchan)
	fi;
	run Anonymous1(hchan,uchan,cchan,cchan);
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				fi
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				fi
			fi
		:: true -> 
			
			if
			:: true -> 
				Chandef cchan;
				
				if
				:: 1 > 0 -> 
					cchan.size = 1;
					run AsyncChan(cchan)
				:: else -> 
					run sync_monitor(cchan)
				fi;
				run Anonymous2(hchan,uchan,cchan,cchan)
			:: true -> 
				Chandef cchan;
				
				if
				:: 1 > 0 -> 
					cchan.size = 1;
					run AsyncChan(cchan)
				:: else -> 
					run sync_monitor(cchan)
				fi;
				run Anonymous3(hchan,uchan,cchan,cchan)
			:: true -> 
				Chandef cchan;
				
				if
				:: 1 > 0 -> 
					cchan.size = 1;
					run AsyncChan(cchan)
				:: else -> 
					run sync_monitor(cchan)
				fi;
				run Anonymous3(hchan,uchan,cchan,cchan)
			fi
		fi
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	fi;
	
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
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef hchan;Chandef uchan;Chandef cchan;Chandef cchan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: hchan.async_send!0;
	:: hchan.sync!0 -> 
		hchan.sending?0
	fi;
	hchan.closing!true;
stop_process:
}
proctype Anonymous1(Chandef hchan;Chandef uchan;Chandef cchan;Chandef cchan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: uchan.async_send!0;
	:: uchan.sync!0 -> 
		uchan.sending?0
	fi;
	uchan.closing!true;
stop_process:
}
proctype Anonymous2(Chandef hchan;Chandef uchan;Chandef cchan;Chandef cchan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: cchan.async_send!0;
	:: cchan.sync!0 -> 
		cchan.sending?0
	fi;
	cchan.closing!true;
stop_process:
}
proctype Anonymous3(Chandef hchan;Chandef uchan;Chandef cchan;Chandef cchan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: cchan.async_send!0;
	:: cchan.sync!0 -> 
		cchan.sending?0
	fi;
	cchan.closing!true;
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

