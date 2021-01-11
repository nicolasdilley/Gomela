#define Run_maxCount  3
#define ub_for97_1  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example710248287/graph/diff.go
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
	Chandef processing;
	bool state = false;
	int i;
	int commons=0;
	int missings=0;
	int extras=1;
	int maxCount = Run_maxCount;
	

	if
	:: maxCount > 0 -> 
		processing.size = maxCount;
		run AsyncChan(processing)
	:: else -> 
		run sync_monitor(processing)
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: processing.async_send!0;
	:: processing.sync!0 -> 
		processing.sending?0
	fi;
	

	if
	:: 0 != -2 && ub_for97_1 != -2 -> 
				for(i : 0.. ub_for97_1) {
			for10814: skip;
			do
			:: processing.async_rcv?0 -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: extras-1 != -3 -> 
										for(i : 0.. extras-1) {
						for11814: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for11_end814: skip
					};
					for11_exit814: skip
				:: else -> 
					do
					:: true -> 
						for11810814: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for11_end810814: skip
					:: true -> 
						break
					od;
					for11_exit810814: skip
				fi;
				

				if
				:: missings-1 != -3 -> 
										for(i : 0.. missings-1) {
						for12814: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for12_end814: skip
					};
					for12_exit814: skip
				:: else -> 
					do
					:: true -> 
						for12811814: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for12_end811814: skip
					:: true -> 
						break
					od;
					for12_exit811814: skip
				fi;
				

				if
				:: commons-1 != -3 -> 
										for(i : 0.. commons-1) {
						for13814: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for13_end814: skip
					};
					for13_exit814: skip
				:: else -> 
					do
					:: true -> 
						for13812814: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for13_end812814: skip
					:: true -> 
						break
					od;
					for13_exit812814: skip
				fi;
				break
			:: processing.sync?0 -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: extras-1 != -3 -> 
										for(i : 0.. extras-1) {
						for11813814: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for11_end813814: skip
					};
					for11_exit813814: skip
				:: else -> 
					do
					:: true -> 
						for11810813814: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for11_end810813814: skip
					:: true -> 
						break
					od;
					for11_exit810813814: skip
				fi;
				

				if
				:: missings-1 != -3 -> 
										for(i : 0.. missings-1) {
						for12813814: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for12_end813814: skip
					};
					for12_exit813814: skip
				:: else -> 
					do
					:: true -> 
						for12811813814: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for12_end811813814: skip
					:: true -> 
						break
					od;
					for12_exit811813814: skip
				fi;
				

				if
				:: commons-1 != -3 -> 
										for(i : 0.. commons-1) {
						for13813814: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for13_end813814: skip
					};
					for13_exit813814: skip
				:: else -> 
					do
					:: true -> 
						for13812813814: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for13_end812813814: skip
					:: true -> 
						break
					od;
					for13_exit812813814: skip
				fi;
				break
			od;
			for10_end814: skip
		};
		for10_exit814: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			do
			:: processing.async_rcv?0 -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: extras-1 != -3 -> 
										for(i : 0.. extras-1) {
						for11: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for11_end: skip
					};
					for11_exit: skip
				:: else -> 
					do
					:: true -> 
						for11810: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for11_end810: skip
					:: true -> 
						break
					od;
					for11_exit810: skip
				fi;
				

				if
				:: missings-1 != -3 -> 
										for(i : 0.. missings-1) {
						for12: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for12_end: skip
					};
					for12_exit: skip
				:: else -> 
					do
					:: true -> 
						for12811: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for12_end811: skip
					:: true -> 
						break
					od;
					for12_exit811: skip
				fi;
				

				if
				:: commons-1 != -3 -> 
										for(i : 0.. commons-1) {
						for13: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for13_end: skip
					};
					for13_exit: skip
				:: else -> 
					do
					:: true -> 
						for13812: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for13_end812: skip
					:: true -> 
						break
					od;
					for13_exit812: skip
				fi;
				break
			:: processing.sync?0 -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: extras-1 != -3 -> 
										for(i : 0.. extras-1) {
						for11813: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for11_end813: skip
					};
					for11_exit813: skip
				:: else -> 
					do
					:: true -> 
						for11810813: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for11_end810813: skip
					:: true -> 
						break
					od;
					for11_exit810813: skip
				fi;
				

				if
				:: missings-1 != -3 -> 
										for(i : 0.. missings-1) {
						for12813: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for12_end813: skip
					};
					for12_exit813: skip
				:: else -> 
					do
					:: true -> 
						for12811813: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for12_end811813: skip
					:: true -> 
						break
					od;
					for12_exit811813: skip
				fi;
				

				if
				:: commons-1 != -3 -> 
										for(i : 0.. commons-1) {
						for13813: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for13_end813: skip
					};
					for13_exit813: skip
				:: else -> 
					do
					:: true -> 
						for13812813: skip;
						

						if
						:: true -> 
							

							if
							:: processing.async_send!0;
							:: processing.sync!0 -> 
								processing.sending?0
							fi
						:: true;
						fi;
						for13_end812813: skip
					:: true -> 
						break
					od;
					for13_exit812813: skip
				fi;
				break
			od;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
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


