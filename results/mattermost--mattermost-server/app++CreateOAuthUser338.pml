
// https://github.com/mattermost/mattermost-server/blob/caeda90b246b2830ffc29901efce685a08d638fa/app/user.go#L338
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
	Chandef euchan;
	Chandef suchan;
	int num_msgs = 0;
	bool state = false;
	int i;
	

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
	:: 1 > 0 -> 
		suchan.size = 1;
		run AsyncChan(suchan)
	:: else -> 
		run sync_monitor(suchan)
	fi;
	

	if
	:: 1 > 0 -> 
		euchan.size = 1;
		run AsyncChan(euchan)
	:: else -> 
		run sync_monitor(euchan)
	fi;
	run go_Anonymous0(suchan,euchan);
	run go_Anonymous1(suchan,euchan);
	

	if
	:: suchan.async_rcv?state,num_msgs;
	:: suchan.sync?state,num_msgs;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: euchan.async_rcv?state,num_msgs;
	:: euchan.sync?state,num_msgs;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
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
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef suchan;Chandef euchan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: suchan.async_send!0;
	:: suchan.sync!false,0 -> 
		suchan.sending?state
	fi;
	suchan.closing!true;
	stop_process: skip
}
proctype go_Anonymous1(Chandef suchan;Chandef euchan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: euchan.async_send!0;
	:: euchan.sync!false,0 -> 
		euchan.sending?state
	fi;
	euchan.closing!true;
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

