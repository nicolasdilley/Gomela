
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example734625780/app/channel.go
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
	Chandef mcc;
	Chandef uc;
	Chandef sc;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 1 > 0 -> 
		sc.size = 1;
		run AsyncChan(sc)
	:: else -> 
		run sync_monitor(sc)
	fi;
	run go_Anonymous0(sc);
	

	if
	:: 1 > 0 -> 
		uc.size = 1;
		run AsyncChan(uc)
	:: else -> 
		run sync_monitor(uc)
	fi;
	run go_Anonymous1(sc,uc);
	

	if
	:: 1 > 0 -> 
		mcc.size = 1;
		run AsyncChan(mcc)
	:: else -> 
		run sync_monitor(mcc)
	fi;
	run go_Anonymous2(sc,uc,mcc);
	

	if
	:: sc.async_rcv?state,num_msgs;
	:: sc.sync?state,num_msgs;
	fi;
	

	if
	:: uc.async_rcv?state,num_msgs;
	:: uc.sync?state,num_msgs;
	fi;
	

	if
	:: mcc.async_rcv?state,num_msgs;
	:: mcc.sync?state,num_msgs;
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

proctype go_Anonymous0(Chandef sc) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: sc.async_send!0;
	:: sc.sync!false,0 -> 
		sc.sending?state
	fi;
	sc.closing!true;
	stop_process: skip
}
proctype go_Anonymous1(Chandef sc;Chandef uc) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: uc.async_send!0;
	:: uc.sync!false,0 -> 
		uc.sending?state
	fi;
	uc.closing!true;
	stop_process: skip
}
proctype go_Anonymous2(Chandef sc;Chandef uc;Chandef mcc) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: mcc.async_send!0;
	:: mcc.sync!false,0 -> 
		mcc.sending?state
	fi;
	mcc.closing!true;
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

