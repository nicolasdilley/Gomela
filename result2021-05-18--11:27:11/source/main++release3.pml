// num_comm_params=3
// num_mand_comm_params=1
// num_opt_comm_params=2

// git_link=https://github.com//blob///Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/source/hello.go#L3
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
	chan child_release30 = [1] of {int};
	run release3(child_release30)
stop_process:skip
}

proctype release3(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_a190 = [1] of {int};
	Chandef c;
	int g = -2; // opt g
	int k = -2; // opt k
	int n = release_n; // mand n
	

	if
	:: n > 0 -> 
		c.size = n;
		run AsyncChan(c)
	:: else -> 
		run sync_monitor(c)
	fi;
	

	if
	:: 0 != -2 && k-1 != -3 -> 
				for(i : 0.. k-1) {
			for11: skip;
			

			if
			:: c.deq?state,num_msgs;
			:: c.sync?state -> 
				c.rcving!false
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: c.deq?state,num_msgs;
			:: c.sync?state -> 
				c.rcving!false
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run a19(c,g,child_a190);
		defer1: skip;
	c.closing!true;
	stop_process: skip;
	child!0
}
proctype a19(Chandef c;int g;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && g-1 != -3 -> 
				for(i : 0.. g-1) {
			for21: skip;
			

			if
			:: c.deq?state,num_msgs;
			:: c.sync?state -> 
				c.rcving!false
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: c.deq?state,num_msgs;
			:: c.sync?state -> 
				c.rcving!false
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
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

