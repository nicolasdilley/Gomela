
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example734625780/app/webhook.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef cchan;
	Chandef cchan;
	Chandef uchan;
	Chandef hchan;
	int num_msgs = 0;
	bool state = false;
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
	run go_Anonymous0(hchan);
	

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
	:: hchan.async_rcv?state,num_msgs;
	:: hchan.sync?state,num_msgs;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 1 > 0 -> 
		uchan.size = 1;
		run AsyncChan(uchan)
	:: else -> 
		run sync_monitor(uchan)
	fi;
	run go_Anonymous1(hchan,uchan);
	

	if
	:: true -> 
		

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
			fi
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: 1 > 0 -> 
					cchan.size = 1;
					run AsyncChan(cchan)
				:: else -> 
					run sync_monitor(cchan)
				fi;
				run go_Anonymous2(hchan,uchan,cchan)
			:: true -> 
				

				if
				:: 1 > 0 -> 
					cchan.size = 1;
					run AsyncChan(cchan)
				:: else -> 
					run sync_monitor(cchan)
				fi;
				run go_Anonymous3(hchan,uchan,cchan)
			fi
		fi
	fi;
	

	if
	:: true -> 
		

		if
		:: cchan.async_rcv?state,num_msgs;
		:: cchan.sync?state,num_msgs;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: uchan.async_rcv?state,num_msgs;
	:: uchan.sync?state,num_msgs;
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef hchan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: hchan.async_send!0;
	:: hchan.sync!false,0 -> 
		hchan.sending?state
	fi;
	hchan.closing!true;
	stop_process: skip
}
proctype go_Anonymous1(Chandef hchan;Chandef uchan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: uchan.async_send!0;
	:: uchan.sync!false,0 -> 
		uchan.sending?state
	fi;
	uchan.closing!true;
	stop_process: skip
}
proctype go_Anonymous2(Chandef hchan;Chandef uchan;Chandef cchan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: cchan.async_send!0;
	:: cchan.sync!false,0 -> 
		cchan.sending?state
	fi;
	cchan.closing!true;
	stop_process: skip
}
proctype go_Anonymous3(Chandef hchan;Chandef uchan;Chandef cchan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: cchan.async_send!0;
	:: cchan.sync!false,0 -> 
		cchan.sending?state
	fi;
	cchan.closing!true;
	stop_process: skip
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

