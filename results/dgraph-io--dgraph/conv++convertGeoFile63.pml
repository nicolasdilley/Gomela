
// https://github.com/dgraph-io/dgraph/blob/master/dgraph/cmd/conv/conv.go#L63
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
	chan child_convertGeoFile630 = [1] of {int};
	run convertGeoFile63(child_convertGeoFile630)
stop_process:skip
}

proctype convertGeoFile63(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousconvertGeoFile91890 = [1] of {int};
	Chandef chb;
	Chandef che;
	int fc_Features=1;
	int f_Properties=0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 1 > 0 -> 
		che.size = 1;
		run AsyncChan(che)
	:: else -> 
		run sync_monitor(che)
	fi;
	

	if
	:: 1000 > 0 -> 
		chb.size = 1000;
		run AsyncChan(chb)
	:: else -> 
		run sync_monitor(chb)
	fi;
	run AnonymousconvertGeoFile9189(che,chb,child_AnonymousconvertGeoFile91890);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: fc_Features-1 != -3 -> 
				for(i : 0.. fc_Features-1) {
			for20: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: chb.enq!0;
			:: chb.sync!false -> 
				chb.sending!false
			fi;
			

			if
			:: f_Properties-1 != -3 -> 
								for(i : 0.. f_Properties-1) {
					for21: skip;
					

					if
					:: true -> 
						

						if
						:: chb.enq!0;
						:: chb.sync!false -> 
							chb.sending!false
						fi
					:: true;
					fi;
					for21_end: skip
				};
				for21_exit: skip
			:: else -> 
				do
				:: true -> 
					for22: skip;
					

					if
					:: true -> 
						

						if
						:: chb.enq!0;
						:: chb.sync!false -> 
							chb.sending!false
						fi
					:: true;
					fi;
					for22_end: skip
				:: true -> 
					break
				od;
				for22_exit: skip
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for23: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: chb.enq!0;
			:: chb.sync!false -> 
				chb.sending!false
			fi;
			

			if
			:: f_Properties-1 != -3 -> 
								for(i : 0.. f_Properties-1) {
					for24: skip;
					

					if
					:: true -> 
						

						if
						:: chb.enq!0;
						:: chb.sync!false -> 
							chb.sending!false
						fi
					:: true;
					fi;
					for24_end: skip
				};
				for24_exit: skip
			:: else -> 
				do
				:: true -> 
					for25: skip;
					

					if
					:: true -> 
						

						if
						:: chb.enq!0;
						:: chb.sync!false -> 
							chb.sending!false
						fi
					:: true;
					fi;
					for25_end: skip
				:: true -> 
					break
				od;
				for25_exit: skip
			fi;
			for23_end: skip
		:: true -> 
			break
		od;
		for23_exit: skip
	fi;
	chb.closing!true;
	

	if
	:: che.deq?state,num_msgs;
	:: che.sync?state -> 
		che.rcving!false
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousconvertGeoFile9189(Chandef che;Chandef chb;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeToFile350 = [1] of {int};
	run writeToFile35(chb,child_writeToFile350);
	child_writeToFile350?0;
	

	if
	:: che.enq!0;
	:: che.sync!false -> 
		che.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype writeToFile35(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
		

		if
		:: ch.deq?state,num_msgs;
		:: ch.sync?state -> 
			ch.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for10: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		fi
	od;
	for10_exit: skip;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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


