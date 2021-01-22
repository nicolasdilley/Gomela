
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example581617033/catalog/filter.go
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
	Chandef fc_Messages;
	Chandef fc_Output;
	Chandef fc_Input;
	int num_msgs = 0;
	bool state = false;
	int i;
	int rules=3;
	run sync_monitor(fc_Input);
	run sync_monitor(fc_Output);
	run sync_monitor(fc_Messages);
	

	if
	:: true -> 
		

		if
		:: rules-1 != -3 -> 
						for(i : 0.. rules-1) {
				for10: skip;
				

				if
				:: true -> 
					

					if
					:: fc_Messages.async_send!0;
					:: fc_Messages.sync!false,0 -> 
						fc_Messages.sending?state
					fi;
					goto for10_end
				:: true -> 
					

					if
					:: true -> 
						

						if
						:: fc_Messages.async_send!0;
						:: fc_Messages.sync!false,0 -> 
							fc_Messages.sending?state
						fi;
						goto for10_end
					:: true;
					fi
				fi;
				

				if
				:: true -> 
					

					if
					:: fc_Messages.async_send!0;
					:: fc_Messages.sync!false,0 -> 
						fc_Messages.sending?state
					fi;
					goto for10_end
				:: true;
				fi;
				for10_end: skip
			};
			for10_exit: skip
		:: else -> 
			do
			:: true -> 
				for102221: skip;
				

				if
				:: true -> 
					

					if
					:: fc_Messages.async_send!0;
					:: fc_Messages.sync!false,0 -> 
						fc_Messages.sending?state
					fi;
					goto for10_end2221
				:: true -> 
					

					if
					:: true -> 
						

						if
						:: fc_Messages.async_send!0;
						:: fc_Messages.sync!false,0 -> 
							fc_Messages.sending?state
						fi;
						goto for10_end2221
					:: true;
					fi
				fi;
				

				if
				:: true -> 
					

					if
					:: fc_Messages.async_send!0;
					:: fc_Messages.sync!false,0 -> 
						fc_Messages.sending?state
					fi;
					goto for10_end2221
				:: true;
				fi;
				for10_end2221: skip
			:: true -> 
				break
			od;
			for10_exit2221: skip
		fi
	:: true;
	fi;
	goto stop_process
stop_process:skip
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


