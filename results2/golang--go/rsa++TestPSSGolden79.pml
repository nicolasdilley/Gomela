// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/crypto/rsa/pss_test.go#L79
#define ub_for101_3  -2
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
	chan child_TestPSSGolden790 = [1] of {int};
	run TestPSSGolden79(child_TestPSSGolden790);
	run receiver(child_TestPSSGolden790)
stop_process:skip
}

proctype TestPSSGolden79(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestPSSGolden95930 = [1] of {int};
	Chandef values;
	run sync_monitor(values);
	run AnonymousTestPSSGolden9593(values,child_AnonymousTestPSSGolden95930);
	run receiver(child_AnonymousTestPSSGolden95930);
	do
	:: true -> 
		num_msgs = 0;
		

		if
		:: values.deq?state,num_msgs;
		:: values.sync?state -> 
			values.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			

			if
			:: true -> 
				

				if
				:: values.deq?state,num_msgs;
				:: values.sync?state -> 
					values.rcving!false
				fi;
				
				if
				:: state && num_msgs > 0 -> 
					goto for20_end
				:: else;
				fi;
				

				if
				:: values.deq?state,num_msgs;
				:: values.sync?state -> 
					values.rcving!false
				fi;
				

				if
				:: 0 != -2 && 6-1 != -3 -> 
										for(i : 0.. 6-1) {
						for22: skip;
						

						if
						:: values.deq?state,num_msgs;
						:: values.sync?state -> 
							values.rcving!false
						fi;
						for22_end: skip
					};
					for22_exit: skip
				:: else -> 
					do
					:: true -> 
						for21: skip;
						

						if
						:: values.deq?state,num_msgs;
						:: values.sync?state -> 
							values.rcving!false
						fi;
						for21_end: skip
					:: true -> 
						break
					od;
					for21_exit: skip
				fi
			:: true -> 
				

				if
				:: values.deq?state,num_msgs;
				:: values.sync?state -> 
					values.rcving!false
				fi;
				

				if
				:: values.deq?state,num_msgs;
				:: values.sync?state -> 
					values.rcving!false
				fi;
				

				if
				:: values.deq?state,num_msgs;
				:: values.sync?state -> 
					values.rcving!false
				fi
			:: true;
			fi;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestPSSGolden9593(Chandef values;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && ub_for101_3 != -2 -> 
				for(i : 0.. ub_for101_3) {
			for11: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: values.enq!0;
					:: values.sync!false -> 
						values.sending!false
					fi
				:: true;
				fi;
				goto for11_end
			:: true -> 
				

				if
				:: values.enq!0;
				:: values.sync!false -> 
					values.sending!false
				fi
			:: true -> 
				

				if
				:: values.enq!0;
				:: values.sync!false -> 
					values.sending!false
				fi
			:: true -> 
				goto for11_end
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
				:: true -> 
					

					if
					:: values.enq!0;
					:: values.sync!false -> 
						values.sending!false
					fi
				:: true;
				fi;
				goto for10_end
			:: true -> 
				

				if
				:: values.enq!0;
				:: values.sync!false -> 
					values.sending!false
				fi
			:: true -> 
				

				if
				:: values.enq!0;
				:: values.sync!false -> 
					values.sending!false
				fi
			:: true -> 
				goto for10_end
			:: true;
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
		defer1: skip;
	values.closing!true;
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

