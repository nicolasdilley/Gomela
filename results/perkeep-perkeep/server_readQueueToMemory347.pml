#define ub_for547_0  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example928961956/pkg/server/sync.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef intr;
	Chandef blobs;
	Chandef errc;
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
	:: blobs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: blobs.async_rcv?0;
			:: blobs.sync?0;
			fi;
			for20: skip;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	

	if
	:: errc.async_rcv?0;
	:: errc.sync?0;
	fi;
	goto stop_process;
	intr.closing!true
stop_process:skip
}

proctype go_Anonymous0(Chandef errc;Chandef blobs;Chandef intr) {
	bool closed; 
	int i;
	bool state;
	chan child_enumerateQueuedBlobs0 = [0] of {int};
	run enumerateQueuedBlobs(blobs,intr,child_enumerateQueuedBlobs0);
	child_enumerateQueuedBlobs0?0;
	

	if
	:: errc.async_send!0;
	:: errc.sync!0 -> 
		errc.sending?0
	fi;
	stop_process: skip
}
proctype enumerateQueuedBlobs(Chandef dst;Chandef intr;chan child) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: 0 != -2 && ub_for547_0 != -2 -> 
				for(i : 0.. ub_for547_0) {
			for1025: skip;
			

			if
			:: true -> 
				goto for10_end25
			:: true;
			fi;
			do
			:: dst.async_send!0 -> 
				break
			:: dst.sync!0 -> 
				dst.sending?0;
				break
			:: intr.async_rcv?0 -> 
				goto stop_process
			:: intr.sync?0 -> 
				goto stop_process
			od;
			for10_end25: skip
		};
		for10_exit25: skip
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
				dst.sending?0;
				break
			:: intr.async_rcv?0 -> 
				goto stop_process
			:: intr.sync?0 -> 
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

