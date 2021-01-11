
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example976469541/plugins/smtp/smtp_output.go
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
	Chandef s_inMessage;
	bool state = false;
	int i;
	int inChan=3;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: 1 > 0 -> 
			s_inMessage.size = 1;
			run AsyncChan(s_inMessage)
		:: else -> 
			run sync_monitor(s_inMessage)
		fi
	:: true;
	fi;
	

	if
	:: inChan-1 != -3 -> 
				for(i : 0.. inChan-1) {
			for10: skip;
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto for10_end
				:: true;
				fi
			:: true -> 
				

				if
				:: s_inMessage.async_send!0;
				:: s_inMessage.sync!0 -> 
					s_inMessage.sending?0
				fi
			:: true -> 
				

				if
				:: s_inMessage.async_send!0;
				:: s_inMessage.sync!0 -> 
					s_inMessage.sending?0
				fi
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for10910: skip;
			

			if
			:: true -> 
				goto for10_end910
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto for10_end910
				:: true;
				fi
			:: true -> 
				

				if
				:: s_inMessage.async_send!0;
				:: s_inMessage.sync!0 -> 
					s_inMessage.sending?0
				fi
			:: true -> 
				

				if
				:: s_inMessage.async_send!0;
				:: s_inMessage.sync!0 -> 
					s_inMessage.sending?0
				fi
			fi;
			for10_end910: skip
		:: true -> 
			break
		od;
		for10_exit910: skip
	fi;
	goto stop_process
stop_process:skip
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


