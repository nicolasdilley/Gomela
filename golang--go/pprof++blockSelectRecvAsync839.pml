// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/pprof/pprof_test.go#L839
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
	chan child_blockSelectRecvAsync8390 = [1] of {int};
	run blockSelectRecvAsync839(child_blockSelectRecvAsync8390);
	run receiver(child_blockSelectRecvAsync8390)
stop_process:skip
}

proctype blockSelectRecvAsync839(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousblockSelectRecvAsync8438410 = [1] of {int};
	Chandef c2_ch;
	Chandef c_ch;
	

	if
	:: 1 > 0 -> 
		c_ch.size = 1;
		run AsyncChan(c_ch)
	:: else -> 
		run sync_monitor(c_ch)
	fi;
	

	if
	:: 1 > 0 -> 
		c2_ch.size = 1;
		run AsyncChan(c2_ch)
	:: else -> 
		run sync_monitor(c2_ch)
	fi;
	run AnonymousblockSelectRecvAsync843841(c_ch,c2_ch,child_AnonymousblockSelectRecvAsync8438410);
	run receiver(child_AnonymousblockSelectRecvAsync8438410);
	

	if
	:: 0 != -2 && 3-1 != -3 -> 
				for(i : 0.. 3-1) {
			for22: skip;
			do
			:: c_ch.deq?state,num_msgs -> 
				break
			:: c_ch.sync?state -> 
				c_ch.rcving!false;
				break
			:: c2_ch.deq?state,num_msgs -> 
				break
			:: c2_ch.sync?state -> 
				c2_ch.rcving!false;
				break
			od;
			for23_exit: skip;
			for22_end: skip
		};
		for22_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			do
			:: c_ch.deq?state,num_msgs -> 
				break
			:: c_ch.sync?state -> 
				c_ch.rcving!false;
				break
			:: c2_ch.deq?state,num_msgs -> 
				break
			:: c2_ch.sync?state -> 
				c2_ch.rcving!false;
				break
			od;
			for21_exit: skip;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousblockSelectRecvAsync843841(Chandef c_ch;Chandef c2_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && 3-1 != -3 -> 
				for(i : 0.. 3-1) {
			for11: skip;
			

			if
			:: c_ch.enq!0;
			:: c_ch.sync!false -> 
				c_ch.sending!false
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: c_ch.enq!0;
			:: c_ch.sync!false -> 
				c_ch.sending!false
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
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

