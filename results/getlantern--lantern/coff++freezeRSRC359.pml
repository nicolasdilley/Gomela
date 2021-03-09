
// https://github.com/getlantern/lantern/blob/c972d9c24cf83d18709fa1eb29079f28c3d620c9/archive/src/github.com/akavel/rsrc/coff/coff.go#L359
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
	Chandef leafwalker;
	int num_msgs = 0;
	bool state = false;
	int i;
	run sync_monitor(leafwalker);
	run go_Anonymous0(leafwalker)
stop_process:skip
}

proctype go_Anonymous0(Chandef leafwalker) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int dir2_DirEntries=1;
	int dir1_Dirs=1;
	int coff_Dir_Dirs=1;
	

	if
	:: coff_Dir_Dirs-1 != -3 -> 
				for(i : 0.. coff_Dir_Dirs-1) {
			for10: skip;
			

			if
			:: dir1_Dirs-1 != -3 -> 
								for(i : 0.. dir1_Dirs-1) {
					for11: skip;
					

					if
					:: dir2_DirEntries-1 != -3 -> 
												for(i : 0.. dir2_DirEntries-1) {
							for12: skip;
							

							if
							:: leafwalker.async_send!0;
							:: leafwalker.sync!false,0 -> 
								leafwalker.sending?state
							fi;
							for12_end: skip
						};
						for12_exit: skip
					:: else -> 
						do
						:: true -> 
							for12289: skip;
							

							if
							:: leafwalker.async_send!0;
							:: leafwalker.sync!false,0 -> 
								leafwalker.sending?state
							fi;
							for12_end289: skip
						:: true -> 
							break
						od;
						for12_exit289: skip
					fi;
					for11_end: skip
				};
				for11_exit: skip
			:: else -> 
				do
				:: true -> 
					for11290: skip;
					

					if
					:: dir2_DirEntries-1 != -3 -> 
												for(i : 0.. dir2_DirEntries-1) {
							for12290: skip;
							

							if
							:: leafwalker.async_send!0;
							:: leafwalker.sync!false,0 -> 
								leafwalker.sending?state
							fi;
							for12_end290: skip
						};
						for12_exit290: skip
					:: else -> 
						do
						:: true -> 
							for12289290: skip;
							

							if
							:: leafwalker.async_send!0;
							:: leafwalker.sync!false,0 -> 
								leafwalker.sending?state
							fi;
							for12_end289290: skip
						:: true -> 
							break
						od;
						for12_exit289290: skip
					fi;
					for11_end290: skip
				:: true -> 
					break
				od;
				for11_exit290: skip
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for10291: skip;
			

			if
			:: dir1_Dirs-1 != -3 -> 
								for(i : 0.. dir1_Dirs-1) {
					for11291: skip;
					

					if
					:: dir2_DirEntries-1 != -3 -> 
												for(i : 0.. dir2_DirEntries-1) {
							for12291: skip;
							

							if
							:: leafwalker.async_send!0;
							:: leafwalker.sync!false,0 -> 
								leafwalker.sending?state
							fi;
							for12_end291: skip
						};
						for12_exit291: skip
					:: else -> 
						do
						:: true -> 
							for12289291: skip;
							

							if
							:: leafwalker.async_send!0;
							:: leafwalker.sync!false,0 -> 
								leafwalker.sending?state
							fi;
							for12_end289291: skip
						:: true -> 
							break
						od;
						for12_exit289291: skip
					fi;
					for11_end291: skip
				};
				for11_exit291: skip
			:: else -> 
				do
				:: true -> 
					for11290291: skip;
					

					if
					:: dir2_DirEntries-1 != -3 -> 
												for(i : 0.. dir2_DirEntries-1) {
							for12290291: skip;
							

							if
							:: leafwalker.async_send!0;
							:: leafwalker.sync!false,0 -> 
								leafwalker.sending?state
							fi;
							for12_end290291: skip
						};
						for12_exit290291: skip
					:: else -> 
						do
						:: true -> 
							for12289290291: skip;
							

							if
							:: leafwalker.async_send!0;
							:: leafwalker.sync!false,0 -> 
								leafwalker.sending?state
							fi;
							for12_end289290291: skip
						:: true -> 
							break
						od;
						for12_exit289290291: skip
					fi;
					for11_end290291: skip
				:: true -> 
					break
				od;
				for11_exit290291: skip
			fi;
			for10_end291: skip
		:: true -> 
			break
		od;
		for10_exit291: skip
	fi;
	stop_process: skip
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


