#define ub_for547_0  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example500871849/pkg/server/sync.go
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
	Chandef intr;
	Chandef blobs;
	Chandef errc;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 1 > 0 -> 
		errc.size = 1;
		run AsyncChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
	

	if
	:: 16 > 0 -> 
		blobs.size = 16;
		run AsyncChan(blobs)
	:: else -> 
		run sync_monitor(blobs)
	fi;
	run sync_monitor(intr);
	run go_Anonymous0(errc,blobs,intr);
	do
	:: true -> 
		

		if
		:: blobs.async_rcv?state,num_msgs;
		:: blobs.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	

	if
	:: errc.async_rcv?state,num_msgs;
	:: errc.sync?state,num_msgs;
	fi;
	goto stop_process;
	intr.closing!true
stop_process:skip
}

proctype go_Anonymous0(Chandef errc;Chandef blobs;Chandef intr) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_enumerateQueuedBlobs0 = [0] of {int};
	run enumerateQueuedBlobs(blobs,intr,child_enumerateQueuedBlobs0);
	child_enumerateQueuedBlobs0?0;
	

	if
	:: errc.async_send!0;
	:: errc.sync!false,0 -> 
		errc.sending?state
	fi;
	stop_process: skip
}
proctype enumerateQueuedBlobs(Chandef dst;Chandef intr;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && ub_for547_0 != -2 -> 
				for(i : 0.. ub_for547_0) {
			for1018: skip;
			

			if
			:: true -> 
				goto for10_end18
			:: true;
			fi;
			do
			:: dst.async_send!0 -> 
				break
			:: dst.sync!0 -> 
				dst.sending?state;
				break
			:: intr.async_rcv?state,num_msgs -> 
				goto stop_process
			:: intr.sync?state,num_msgs -> 
				goto stop_process
			od;
			for10_end18: skip
		};
		for10_exit18: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			do
			:: dst.async_send!0 -> 
				break
			:: dst.sync!0 -> 
				dst.sending?state;
				break
			:: intr.async_rcv?state,num_msgs -> 
				goto stop_process
			:: intr.sync?state,num_msgs -> 
				goto stop_process
			od;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	dst.closing!true;
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

