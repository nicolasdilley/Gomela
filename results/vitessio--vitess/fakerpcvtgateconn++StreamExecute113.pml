#define StreamExecute_response_reply_Rows  3

// https://github.com/vitessio/vitess/blob/d09dffef0c60d5d4841cac86bdf4ed777098b60a/go/vt/vtgate/fakerpcvtgateconn/conn.go#L113
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
	Chandef resultChan;
	Chandef resultChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int response_reply_Rows = StreamExecute_response_reply_Rows;
	

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
	

	if
	:: true -> 
		

		if
		:: response_reply_Rows + 1 > 0 -> 
			resultChan.size = response_reply_Rows + 1;
			run AsyncChan(resultChan)
		:: else -> 
			run sync_monitor(resultChan)
		fi;
		

		if
		:: resultChan.async_send!0;
		:: resultChan.sync!false,0 -> 
			resultChan.sending?state
		fi;
		

		if
		:: response_reply_Rows-1 != -3 -> 
						for(i : 0.. response_reply_Rows-1) {
				for10: skip;
				

				if
				:: resultChan.async_send!0;
				:: resultChan.sync!false,0 -> 
					resultChan.sending?state
				fi;
				for10_end: skip
			};
			for10_exit: skip
		:: else -> 
			do
			:: true -> 
				for10726: skip;
				

				if
				:: resultChan.async_send!0;
				:: resultChan.sync!false,0 -> 
					resultChan.sending?state
				fi;
				for10_end726: skip
			:: true -> 
				break
			od;
			for10_exit726: skip
		fi
	:: true -> 
		run sync_monitor(resultChan)
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

