#define revListIndex_chanBufSize  3
#define ub_for122_1  -2

// https://github.com/git-lfs/git-lfs/blob/731bcc598b2edd1b400a8908a803fd6afdc255ff/lfs/gitscanner_index.go#L112
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
	chan child_lfsNewStringChannelWrapper0 = [0] of {int};
	Chandef errs;
	Chandef revs;
	int num_msgs = 0;
	bool state = false;
	int i;
	int chanBufSize = revListIndex_chanBufSize;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: chanBufSize > 0 -> 
		revs.size = chanBufSize;
		run AsyncChan(revs)
	:: else -> 
		run sync_monitor(revs)
	fi;
	

	if
	:: 1 > 0 -> 
		errs.size = 1;
		run AsyncChan(errs)
	:: else -> 
		run sync_monitor(errs)
	fi;
	run go_Anonymous0(revs,errs);
	run lfsNewStringChannelWrapper(revs,errs,child_lfsNewStringChannelWrapper0);
	child_lfsNewStringChannelWrapper0?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef revs;Chandef errs) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && ub_for122_1 != -2 -> 
				for(i : 0.. ub_for122_1) {
			for10615: skip;
			

			if
			:: revs.async_send!0;
			:: revs.sync!false,0 -> 
				revs.sending?state
			fi;
			for10_end615: skip
		};
		for10_exit615: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: revs.async_send!0;
			:: revs.sync!false,0 -> 
				revs.sending?state
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: true -> 
		

		if
		:: errs.async_send!0;
		:: errs.sync!false,0 -> 
			errs.sending?state
		fi
	:: true;
	fi;
	revs.closing!true;
	errs.closing!true;
	stop_process: skip
}
proctype lfsNewStringChannelWrapper(Chandef stringChan;Chandef errorChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

