#define discoverPMP_gws  3

// https://github.com/ethereum/go-ethereum/blob/master/p2p/nat/natpmp.go#L65
typedef Chandef {
	chan sync = [0] of {bool};
	chan enq = [0] of {int};
	chan deq = [0] of {bool,int};
	chan sending = [0] of {bool};
	chan rcving = [0] of {bool};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	chan child_discoverPMP650 = [1] of {int};
	run discoverPMP65(child_discoverPMP650)
stop_process:skip
}

proctype discoverPMP65(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousdiscoverPMP71680 = [1] of {int};
	Chandef found;
	int gws = discoverPMP_gws;
	

	if
	:: gws > 0 -> 
		found.size = gws;
		run AsyncChan(found)
	:: else -> 
		run sync_monitor(found)
	fi;
		for(i : 0.. gws-1) {
		for10: skip;
		run AnonymousdiscoverPMP7168(found,child_AnonymousdiscoverPMP71680);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: gws-1 != -3 -> 
				for(i : 0.. gws-1) {
			for20: skip;
			do
			:: found.deq?state,num_msgs -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: found.sync?state -> 
				found.rcving!false;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				goto stop_process
			od;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			do
			:: found.deq?state,num_msgs -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: found.sync?state -> 
				found.rcving!false;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				goto stop_process
			od;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousdiscoverPMP7168(Chandef found;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: found.enq!0;
		:: found.sync!false -> 
			found.sending!false
		fi
	:: true -> 
		

		if
		:: found.enq!0;
		:: found.sync!false -> 
			found.sending!false
		fi
	fi;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.rcving?false;
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.sync!true -> 
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.deq!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		    ch.closed = true
		   :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.enq?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.rcving?false ->
 		    ch.sending?false;
		fi;
		:: else -> 
		end3: if
		  :: ch.enq?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.deq!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		     ch.closed = true
		  :: ch.rcving?false ->
 		    ch.sending?false;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.rcving?false;
  :: ch.sync!true; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.rcving?false ->
       ch.sending?false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

