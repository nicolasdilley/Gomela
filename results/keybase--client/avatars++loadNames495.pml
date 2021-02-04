
// https://github.com/keybase/client/blob/cd76ccb97183c2be78b869fab9aed4b6f5b11086/go/avatars/fullcaching.go#L495
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
	Chandef errCb;
	Chandef cb;
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
		

		if
		:: 1 > 0 -> 
			cb.size = 1;
			run AsyncChan(cb)
		:: else -> 
			run sync_monitor(cb)
		fi;
		

		if
		:: 1 > 0 -> 
			errCb.size = 1;
			run AsyncChan(errCb)
		:: else -> 
			run sync_monitor(errCb)
		fi;
		do
		:: cb.async_rcv?state,num_msgs -> 
			break
		:: cb.sync?state,num_msgs -> 
			break
		:: errCb.async_rcv?state,num_msgs -> 
			break
		:: errCb.sync?state,num_msgs -> 
			break
		od
	:: true;
	fi;
	

	if
	:: true -> 
		run go_Anonymous0(cb,errCb)
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef cb;Chandef errCb) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef errCb;
	Chandef cb;
	

	if
	:: 1 > 0 -> 
		cb.size = 1;
		run AsyncChan(cb)
	:: else -> 
		run sync_monitor(cb)
	fi;
	

	if
	:: 1 > 0 -> 
		errCb.size = 1;
		run AsyncChan(errCb)
	:: else -> 
		run sync_monitor(errCb)
	fi;
	do
	:: cb.async_rcv?state,num_msgs -> 
		break
	:: cb.sync?state,num_msgs -> 
		break
	:: errCb.async_rcv?state,num_msgs -> 
		break
	:: errCb.sync?state,num_msgs -> 
		break
	od;
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

