
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example071832406/services/pull/lfs.go
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
	Chandef errChan;
	int i;
	Wgdef wg;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		errChan.size = 1;
		run AsyncChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	run wgMonitor(wg);
	wg.Add!6;
	run go_pullcreateLFSMetaObjectsFromCatFileBatch(wg);
	run go_CatFileBatch(wg);
	run go_BlobsLessThan1024FromCatFileBatchCheck(wg);
	run go_CatFileBatchCheck(wg);
	run go_BlobsFromRevListObjects(wg);
	run go_RevListObjects(wg,errChan);
	wg.Wait?0;
	do
	:: errChan.async_rcv?0 -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: errChan.sync?0 -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: true -> 
		break
	od;
	goto stop_process
stop_process:}

proctype go_pullcreateLFSMetaObjectsFromCatFileBatch(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for10_exit:stop_process:	wg.Add!-1
}
proctype go_CatFileBatch(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
}
proctype go_BlobsLessThan1024FromCatFileBatchCheck(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for71_0 != -2 && ub_for71_1 != -2 -> 
				for(i : lb_for71_0.. ub_for71_1) {
for20:			
			if
			:: lb_for85_2 != -2 && ub_for85_3 != -2 -> 
								for(i : lb_for85_2.. ub_for85_3) {
for21:					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for21:					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for21_exit:
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: lb_for85_2 != -2 && ub_for85_3 != -2 -> 
								for(i : lb_for85_2.. ub_for85_3) {
for21:					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for21:					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for21_exit:
		:: true -> 
			break
		od
	fi;
for20_exit:stop_process:	wg.Add!-1
}
proctype go_CatFileBatchCheck(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
}
proctype go_BlobsFromRevListObjects(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for56_0 != -2 && ub_for56_1 != -2 -> 
				for(i : lb_for56_0.. ub_for56_1) {
for30:			
			if
			:: lb_for66_2 != -2 && ub_for66_3 != -2 -> 
								for(i : lb_for66_2.. ub_for66_3) {
for31:					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for31:					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for31_exit:
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: lb_for66_2 != -2 && ub_for66_3 != -2 -> 
								for(i : lb_for66_2.. ub_for66_3) {
for31:					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for31:					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for31_exit:
		:: true -> 
			break
		od
	fi;
for30_exit:stop_process:	wg.Add!-1
}
proctype go_RevListObjects(Wgdef wg;Chandef errChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: errChan.async_send!0;
		:: errChan.sync!0 -> 
			errChan.sending?0
		fi
	:: true;
	fi;
stop_process:	wg.Add!-1
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
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
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

