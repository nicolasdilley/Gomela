#define DirMove_ci_Transfers  3

// https://github.com/ncw/rclone/blob/80e63af4703730923a97b65fae4d5b712de846c9/fs/operations/operations.go#L1934
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
	Chandef renames;
	int num_msgs = 0;
	bool state = false;
	int i;
	int entries=3;
	int tree=1;
	int ci_Transfers = DirMove_ci_Transfers;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: ci_Transfers > 0 -> 
		renames.size = ci_Transfers;
		run AsyncChan(renames)
	:: else -> 
		run sync_monitor(renames)
	fi;
	

	if
	:: tree-1 != -3 -> 
				for(i : 0.. tree-1) {
			for30: skip;
			

			if
			:: entries-1 != -3 -> 
								for(i : 0.. entries-1) {
					for31: skip;
					

					if
					:: true -> 
						

						if
						:: renames.async_send!0;
						:: renames.sync!false,0 -> 
							renames.sending?state
						fi
					:: true;
					fi;
					for31_end: skip
				};
				for31_exit: skip
			:: else -> 
				do
				:: true -> 
					for311260: skip;
					

					if
					:: true -> 
						

						if
						:: renames.async_send!0;
						:: renames.sync!false,0 -> 
							renames.sending?state
						fi
					:: true;
					fi;
					for31_end1260: skip
				:: true -> 
					break
				od;
				for31_exit1260: skip
			fi;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for301261: skip;
			

			if
			:: entries-1 != -3 -> 
								for(i : 0.. entries-1) {
					for311261: skip;
					

					if
					:: true -> 
						

						if
						:: renames.async_send!0;
						:: renames.sync!false,0 -> 
							renames.sending?state
						fi
					:: true;
					fi;
					for31_end1261: skip
				};
				for31_exit1261: skip
			:: else -> 
				do
				:: true -> 
					for3112601261: skip;
					

					if
					:: true -> 
						

						if
						:: renames.async_send!0;
						:: renames.sync!false,0 -> 
							renames.sending?state
						fi
					:: true;
					fi;
					for31_end12601261: skip
				:: true -> 
					break
				od;
				for31_exit12601261: skip
			fi;
			for30_end1261: skip
		:: true -> 
			break
		od;
		for30_exit1261: skip
	fi;
	renames.closing!true;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
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


