
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example512321996/archive/src/github.com/akavel/rsrc/coff/coff.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef leafwalker;
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
	int dir2_DirEntries=1;
	int dir1_Dirs=1;
	int coff_Dir_Dirs=3;
	

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
							:: leafwalker.sync!0 -> 
								leafwalker.sending?0
							fi;
							for12_end: skip
						};
						for12_exit: skip
					:: else -> 
						do
						:: true -> 
							for12108: skip;
							

							if
							:: leafwalker.async_send!0;
							:: leafwalker.sync!0 -> 
								leafwalker.sending?0
							fi;
							for12_end108: skip
						:: true -> 
							break
						od;
						for12_exit108: skip
					fi;
					for11_end: skip
				};
				for11_exit: skip
			:: else -> 
				do
				:: true -> 
					for11109: skip;
					

					if
					:: dir2_DirEntries-1 != -3 -> 
												for(i : 0.. dir2_DirEntries-1) {
							for12109: skip;
							

							if
							:: leafwalker.async_send!0;
							:: leafwalker.sync!0 -> 
								leafwalker.sending?0
							fi;
							for12_end109: skip
						};
						for12_exit109: skip
					:: else -> 
						do
						:: true -> 
							for12108109: skip;
							

							if
							:: leafwalker.async_send!0;
							:: leafwalker.sync!0 -> 
								leafwalker.sending?0
							fi;
							for12_end108109: skip
						:: true -> 
							break
						od;
						for12_exit108109: skip
					fi;
					for11_end109: skip
				:: true -> 
					break
				od;
				for11_exit109: skip
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for10110: skip;
			

			if
			:: dir1_Dirs-1 != -3 -> 
								for(i : 0.. dir1_Dirs-1) {
					for11110: skip;
					

					if
					:: dir2_DirEntries-1 != -3 -> 
												for(i : 0.. dir2_DirEntries-1) {
							for12110: skip;
							

							if
							:: leafwalker.async_send!0;
							:: leafwalker.sync!0 -> 
								leafwalker.sending?0
							fi;
							for12_end110: skip
						};
						for12_exit110: skip
					:: else -> 
						do
						:: true -> 
							for12108110: skip;
							

							if
							:: leafwalker.async_send!0;
							:: leafwalker.sync!0 -> 
								leafwalker.sending?0
							fi;
							for12_end108110: skip
						:: true -> 
							break
						od;
						for12_exit108110: skip
					fi;
					for11_end110: skip
				};
				for11_exit110: skip
			:: else -> 
				do
				:: true -> 
					for11109110: skip;
					

					if
					:: dir2_DirEntries-1 != -3 -> 
												for(i : 0.. dir2_DirEntries-1) {
							for12109110: skip;
							

							if
							:: leafwalker.async_send!0;
							:: leafwalker.sync!0 -> 
								leafwalker.sending?0
							fi;
							for12_end109110: skip
						};
						for12_exit109110: skip
					:: else -> 
						do
						:: true -> 
							for12108109110: skip;
							

							if
							:: leafwalker.async_send!0;
							:: leafwalker.sync!0 -> 
								leafwalker.sending?0
							fi;
							for12_end108109110: skip
						:: true -> 
							break
						od;
						for12_exit108109110: skip
					fi;
					for11_end109110: skip
				:: true -> 
					break
				od;
				for11_exit109110: skip
			fi;
			for10_end110: skip
		:: true -> 
			break
		od;
		for10_exit110: skip
	fi;
	stop_process: skip
}
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}


