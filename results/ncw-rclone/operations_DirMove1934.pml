#define DirMove_ci_Transfers  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example110380261/fs/operations/operations.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef g_wg;
	Chandef renames;
	bool state = false;
	int i;
	int entries=3;
	int tree=3;
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
	run wgMonitor(g_wg);
	

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
						:: renames.sync!0 -> 
							renames.sending?0
						fi
					:: true;
					fi;
					for31_end: skip
				};
				for31_exit: skip
			:: else -> 
				do
				:: true -> 
					for31251: skip;
					

					if
					:: true -> 
						

						if
						:: renames.async_send!0;
						:: renames.sync!0 -> 
							renames.sending?0
						fi
					:: true;
					fi;
					for31_end251: skip
				:: true -> 
					break
				od;
				for31_exit251: skip
			fi;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for30252: skip;
			

			if
			:: entries-1 != -3 -> 
								for(i : 0.. entries-1) {
					for31252: skip;
					

					if
					:: true -> 
						

						if
						:: renames.async_send!0;
						:: renames.sync!0 -> 
							renames.sending?0
						fi
					:: true;
					fi;
					for31_end252: skip
				};
				for31_exit252: skip
			:: else -> 
				do
				:: true -> 
					for31251252: skip;
					

					if
					:: true -> 
						

						if
						:: renames.async_send!0;
						:: renames.sync!0 -> 
							renames.sending?0
						fi
					:: true;
					fi;
					for31_end251252: skip
				:: true -> 
					break
				od;
				for31_exit251252: skip
			fi;
			for30_end252: skip
		:: true -> 
			break
		od;
		for30_exit252: skip
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

proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}


