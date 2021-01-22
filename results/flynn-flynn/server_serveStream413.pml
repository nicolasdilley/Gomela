
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example810706838/discoverd/server/handler.go
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
	chan child_Subscribe0 = [0] of {int};
	Chandef ch;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 64 > 0 -> 
		ch.size = 64;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run Subscribe(ch,child_Subscribe0);
	child_Subscribe0?0
stop_process:skip
}

proctype Subscribe(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int s_instances105224=0;
	

	if
	:: true -> 
		

		if
		:: s_instances105224-1 != -3 -> 
						for(i : 0.. s_instances105224-1) {
				for10: skip;
				

				if
				:: ch.async_send!0;
				:: ch.sync!false,0 -> 
					ch.sending?state
				fi;
				for10_end: skip
			};
			for10_exit: skip
		:: else -> 
			do
			:: true -> 
				for10383: skip;
				

				if
				:: ch.async_send!0;
				:: ch.sync!false,0 -> 
					ch.sending?state
				fi;
				for10_end383: skip
			:: true -> 
				break
			od;
			for10_exit383: skip
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: ch.async_send!0;
		:: ch.sync!false,0 -> 
			ch.sending?state
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: ch.async_send!0;
		:: ch.sync!false,0 -> 
			ch.sending?state
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: ch.async_send!0;
		:: ch.sync!false,0 -> 
			ch.sending?state
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
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


