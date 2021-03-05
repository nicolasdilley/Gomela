
// https://github.com/dgraph-io/dgraph/blob/ee0b99586ab740fbdec6da78605624c7feba2e5d/dgraph/cmd/conv/conv.go#L63
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
	run go_convertGeoFile()
stop_process:skip
}

proctype go_convertGeoFile() {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef chb;
	Chandef che;
	int f_Properties=3;
	int fc_Features=1;
	

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
	run go_Anonymous1(che,chb);
	

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
			:: chb.async_send!0;
			:: chb.sync!false,0 -> 
				chb.sending?state
			fi;
			

			if
			:: f_Properties-1 != -3 -> 
								for(i : 0.. f_Properties-1) {
					for21: skip;
					

					if
					:: true -> 
						

						if
						:: chb.async_send!0;
						:: chb.sync!false,0 -> 
							chb.sending?state
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
						:: chb.async_send!0;
						:: chb.sync!false,0 -> 
							chb.sending?state
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
			:: chb.async_send!0;
			:: chb.sync!false,0 -> 
				chb.sending?state
			fi;
			

			if
			:: f_Properties-1 != -3 -> 
								for(i : 0.. f_Properties-1) {
					for24: skip;
					

					if
					:: true -> 
						

						if
						:: chb.async_send!0;
						:: chb.sync!false,0 -> 
							chb.sending?state
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
						:: chb.async_send!0;
						:: chb.sync!false,0 -> 
							chb.sending?state
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
	:: che.async_rcv?state,num_msgs;
	:: che.sync?state,num_msgs;
	fi;
	goto stop_process;
	stop_process: skip;
	
}
proctype go_Anonymous1(Chandef che;Chandef chb) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_convwriteToFile0 = [0] of {int};
	run convwriteToFile(chb,child_convwriteToFile0);
	child_convwriteToFile0?0;
	

	if
	:: che.async_send!0;
	:: che.sync!false,0 -> 
		che.sending?state
	fi;
	stop_process: skip
}
proctype convwriteToFile(Chandef ch;chan child) {
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
		:: ch.async_rcv?state,num_msgs;
		:: ch.sync?state,num_msgs;
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
	;
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


