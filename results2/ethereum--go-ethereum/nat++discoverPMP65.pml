// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/p2p/nat/natpmp.go#L65
#define discoverPMP_gws  ??
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
	run discoverPMP65(child_discoverPMP650);
	run receiver(child_discoverPMP650)
stop_process:skip
}

proctype discoverPMP65(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousdiscoverPMP71680 = [1] of {int};
	Chandef found_ch;
	int var_gws = discoverPMP_gws; // mand var_gws
	

	if
	:: var_gws > 0 -> 
		found_ch.size = var_gws;
		run AsyncChan(found_ch)
	:: else -> 
		run sync_monitor(found_ch)
	fi;
		for(i : 0.. var_gws-1) {
		for10: skip;
		run AnonymousdiscoverPMP7168(found_ch,child_AnonymousdiscoverPMP71680);
		run receiver(child_AnonymousdiscoverPMP71680);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: var_gws-1 != -3 -> 
				for(i : 0.. var_gws-1) {
			for20: skip;
			do
			:: found_ch.deq?state,num_msgs -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: found_ch.sync?state -> 
				found_ch.rcving!false;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				goto stop_process
			od;
			for21_exit: skip;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for22: skip;
			do
			:: found_ch.deq?state,num_msgs -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: found_ch.sync?state -> 
				found_ch.rcving!false;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				goto stop_process
			od;
			for23_exit: skip;
			for22_end: skip
		:: true -> 
			break
		od;
		for22_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousdiscoverPMP7168(Chandef found_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: found_ch.enq!0;
		:: found_ch.sync!false -> 
			found_ch.sending!false
		fi
	:: true -> 
		

		if
		:: found_ch.enq!0;
		:: found_ch.sync!false -> 
			found_ch.sending!false
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
  :: ch.num_msgs > 0 -> // cannot send on closed channel
    end4: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.deq!true,ch.num_msgs -> 
  		 ch.num_msgs = ch.num_msgs - 1
    fi;
  :: else ->    end5: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.sync!true; 
    fi;
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

proctype receiver(chan c) {
c?0
}

