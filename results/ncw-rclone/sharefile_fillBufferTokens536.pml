#define fillBufferTokens_f_ci_Transfers  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example038413410/backend/sharefile/sharefile.go
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
	Chandef f_bufferTokens;
	int num_msgs = 0;
	bool state = false;
	int i;
	int f_ci_Transfers = fillBufferTokens_f_ci_Transfers;
	

	if
	:: f_ci_Transfers > 0 -> 
		f_bufferTokens.size = f_ci_Transfers;
		run AsyncChan(f_bufferTokens)
	:: else -> 
		run sync_monitor(f_bufferTokens)
	fi;
	

	if
	:: 0 != -2 && f_ci_Transfers-1 != -3 -> 
				for(i : 0.. f_ci_Transfers-1) {
			for101271: skip;
			

			if
			:: f_bufferTokens.async_send!0;
			:: f_bufferTokens.sync!false,0 -> 
				f_bufferTokens.sending?state
			fi;
			for10_end1271: skip
		};
		for10_exit1271: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: f_bufferTokens.async_send!0;
			:: f_bufferTokens.sync!false,0 -> 
				f_bufferTokens.sending?state
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi
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

