#define ScaleDownVMs_numVmsToDelete  1
#define ScaleDownVMs_vmNames  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example582050908/pkg/operations/scaledownagentpool.go
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
	Chandef errChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int vmNames = ScaleDownVMs_vmNames;
	int numVmsToDelete = ScaleDownVMs_numVmsToDelete;
	

	if
	:: numVmsToDelete > 0 -> 
		errChan.size = numVmsToDelete;
		run AsyncChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
		for(i : 0.. vmNames-1) {
		for10: skip;
		run go_Anonymous0(errChan);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && numVmsToDelete-1 != -3 -> 
				for(i : 0.. numVmsToDelete-1) {
			for20417: skip;
			

			if
			:: errChan.async_rcv?state,num_msgs;
			:: errChan.sync?state,num_msgs;
			fi;
			for20_end417: skip
		};
		for20_exit417: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: errChan.async_rcv?state,num_msgs;
			:: errChan.sync?state,num_msgs;
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	errChan.closing!true
stop_process:skip
}

proctype go_Anonymous0(Chandef errChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errChan.async_send!0;
		:: errChan.sync!false,0 -> 
			errChan.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: errChan.async_send!0;
	:: errChan.sync!false,0 -> 
		errChan.sending?state
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

