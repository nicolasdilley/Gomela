// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/sendfile_test.go#L100
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
	chan child_TestSendfileParts1000 = [1] of {int};
	run TestSendfileParts100(child_TestSendfileParts1000);
	run receiver(child_TestSendfileParts1000)
stop_process:skip
}

proctype TestSendfileParts100(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestSendfileParts1081080 = [1] of {int};
	Chandef errc;
	

	if
	:: 1 > 0 -> 
		errc.size = 1;
		run AsyncChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
	run AnonymousTestSendfileParts108108(errc,child_AnonymousTestSendfileParts1081080);
	run receiver(child_AnonymousTestSendfileParts1081080);
	do
	:: true -> 
		num_msgs = 0;
		

		if
		:: errc.deq?state,num_msgs;
		:: errc.sync?state -> 
			errc.rcving!false
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
	stop_process: skip;
	child!0
}
proctype AnonymousTestSendfileParts108108(Chandef errc;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousAnonymousTestSendfileParts1081171070 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: errc.enq!0;
		:: errc.sync!false -> 
			errc.sending!false
		fi;
		errc.closing!true;
		goto stop_process
	:: true;
	fi;
	run AnonymousAnonymousTestSendfileParts108117107(errc,child_AnonymousAnonymousTestSendfileParts1081171070);
	run receiver(child_AnonymousAnonymousTestSendfileParts1081171070);
	stop_process: skip;
	child!0
}
proctype AnonymousAnonymousTestSendfileParts108117107(Chandef errc;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.enq!0;
		:: errc.sync!false -> 
			errc.sending!false
		fi;
		goto defer1
	:: true;
	fi;
	

	if
	:: 0 != -2 && 3-1 != -3 -> 
				for(i : 0.. 3-1) {
			for11: skip;
			

			if
			:: true -> 
				

				if
				:: errc.enq!0;
				:: errc.sync!false -> 
					errc.sending!false
				fi;
				goto defer1
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: errc.enq!0;
				:: errc.sync!false -> 
					errc.sending!false
				fi;
				goto defer1
			:: true;
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
		defer1: skip;
	errc.closing!true;
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

