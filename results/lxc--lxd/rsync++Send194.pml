
// https://github.com/lxc/lxd/blob/6c8d1ba8351d36ae4f0844a7009611b160ef4174/lxd/rsync/rsync.go#L194
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
	Chandef chCopyTarget;
	Chandef chCopyNetcat;
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
		chCopyNetcat.size = 1;
		run AsyncChan(chCopyNetcat)
	:: else -> 
		run sync_monitor(chCopyNetcat)
	fi;
	run go_Anonymous0(chCopyNetcat);
	

	if
	:: 1 > 0 -> 
		chCopyTarget.size = 1;
		run AsyncChan(chCopyTarget)
	:: else -> 
		run sync_monitor(chCopyTarget)
	fi;
	run go_Anonymous1(chCopyNetcat,chCopyTarget);
	

	if
	:: chCopyNetcat.async_rcv?state,num_msgs;
	:: chCopyNetcat.sync?state,num_msgs;
	fi;
	

	if
	:: chCopyTarget.async_rcv?state,num_msgs;
	:: chCopyTarget.sync?state,num_msgs;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef chCopyNetcat) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: chCopyNetcat.async_send!0;
	:: chCopyNetcat.sync!false,0 -> 
		chCopyNetcat.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef chCopyNetcat;Chandef chCopyTarget) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: chCopyTarget.async_send!0;
	:: chCopyTarget.sync!false,0 -> 
		chCopyTarget.sending?state
	fi;
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

